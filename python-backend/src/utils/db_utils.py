from supabase import create_client, Client
from src.utils.logger import logger
from src.schemas.recipe import Recipe, Ingredient, Instruction
from typing import Optional

import os
import hashlib
from dotenv import load_dotenv

load_dotenv()


class SupabaseClient:
    def __init__(self) -> None:
        self.supabase: Client = create_client(
            os.getenv("SUPABASE_URL"), os.getenv("SUPABASE_API_KEY")
        )

    def create_url_hash(self, url: str) -> str:
        return hashlib.sha256(url.encode()).hexdigest()

    async def get_existing_recipe(self, url_hash: str) -> Optional[str]:
        response = (
            self.supabase.table("recipes")
            .select("id")
            .eq("url_hash", url_hash)
            .maybe_single()
            .execute()
        )
        return response.data["id"] if response else None

    async def get_recipe_by_id(self, recipe_id: str) -> dict:
        recipe_data = (
            self.supabase.table("recipes")
            .select("*")
            .eq("id", recipe_id)
            .single()
            .execute()
        )

        ingredients = (
            self.supabase.table("recipe_ingredients")
            .select("ingredients(*), amount, unit, preparation, is_optional, notes")
            .eq("recipe_id", recipe_id)
            .execute()
        )

        instructions = (
            self.supabase.table("instructions")
            .select("*")
            .eq("recipe_id", recipe_id)
            .order("step_number")
            .execute()
        )

        return {
            **recipe_data.data,
            "ingredients": [
                {
                    "item": ing["ingredients"]["item"],
                    "category": ing["ingredients"]["category"],
                    "amount": ing["amount"],
                    "unit": ing["unit"],
                    "preparation": ing["preparation"],
                    "is_optional": ing["is_optional"],
                    "notes": ing["notes"],
                }
                for ing in ingredients.data
            ],
            "instructions": sorted(instructions.data, key=lambda x: x["step_number"]),
        }

    async def insert_base_recipe(self, recipe: Recipe, recipe_url: str) -> str:
        url_hash = self.create_url_hash(recipe_url)

        recipe_response = (
            self.supabase.table("recipes")
            .insert(
                {
                    "title": recipe.title,
                    "servings": recipe.servings,
                    "difficulty": recipe.difficulty,
                    "cook_time_amount": recipe.cookTime.amount
                    if recipe.cookTime
                    else None,
                    "cook_time_unit": recipe.cookTime.unit if recipe.cookTime else None,
                    "url": recipe_url,
                    "url_hash": url_hash,
                }
            )
            .execute()
        )
        return recipe_response.data[0]["id"]

    async def get_or_create_ingredient(self, ingredient: Ingredient) -> str:
        # Try to find the ingredient
        ingredient_response = (
            self.supabase.table("ingredients")
            .select("id")
            .eq("item", ingredient.item)
            .maybe_single()
            .execute()
        )

        if ingredient_response:
            return ingredient_response.data["id"]

        # Create new ingredient
        new_ingredient = (
            self.supabase.table("ingredients")
            .insert({"item": ingredient.item, "category": ingredient.category})
            .execute()
        )

        return new_ingredient.data[0]["id"]

    async def insert_recipe_ingredient(
        self, recipe_id: str, ingredient: Ingredient, ingredient_id: str
    ):
        try:
            recipe_ingredient_response = (
                self.supabase.table("recipe_ingredients")
                .insert(
                    {
                        "recipe_id": recipe_id,
                        "ingredient_id": ingredient_id,
                        "amount": ingredient.amount,
                        "unit": ingredient.unit,
                        "preparation": ingredient.preparation,
                        "is_optional": ingredient.is_optional,
                        "notes": ingredient.notes,
                    }
                )
                .execute()
            )
            return recipe_ingredient_response.data[0]["id"]
        except Exception as e:
            logger.error("Error inserting recipe ingredient: %s", str(e))
            return None

    async def insert_instruction(self, recipe_id: str, instruction: Instruction):
        try:
            instruction_response = (
                self.supabase.table("instructions")
                .insert(
                    {
                        "recipe_id": recipe_id,
                        "step_number": instruction.step,
                        "description": instruction.description,
                        "time_amount": instruction.time.amount
                        if instruction.time
                        else None,
                        "time_unit": instruction.time.unit
                        if instruction.time
                        else None,
                    }
                )
                .execute()
            )
            return instruction_response.data[0]["id"]
        except Exception as e:
            logger.error(f"Error inserting instruction: {str(e)}")
            return None

    async def insert_recipe(self, recipe: Recipe, recipe_url: str) -> str:
        try:
            recipe_id = await self.insert_base_recipe(recipe, recipe_url)

            for ingredient in recipe.ingredients:
                try:
                    ingredient_id = await self.get_or_create_ingredient(ingredient)
                    await self.insert_recipe_ingredient(
                        recipe_id, ingredient, ingredient_id
                    )
                except Exception as e:
                    logger.error(
                        f"Error inserting ingredient {ingredient.item}: {str(e)}"
                    )
                    raise

            for instruction in recipe.instructions:
                try:
                    await self.insert_instruction(recipe_id, instruction)
                except Exception as e:
                    logger.error(
                        f"Error inserting instruction {instruction.step}: {str(e)}"
                    )
                    raise

            return recipe_id
        except Exception as e:
            logger.error(f"Error in insert_recipe: {str(e)}")
            raise
