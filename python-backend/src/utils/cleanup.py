# Combine all ingredients with the sane name, unit, and preparation
# recipe["ingredients"] = combine_ingredients(recipe["ingredients"])

from typing import List
from src.schemas.recipe import Ingredient


def combine_ingredients(ingredients: List[Ingredient]) -> List[Ingredient]:
    """
    Combines ingredients with the same name, unit, and preparation method by summing their amounts.

    Args:
        ingredients (List[Ingredient]): List of ingredients to combine

    Returns:
        List[Ingredient]: List of combined ingredients
    """
    combined = {}

    for ingredient in ingredients:
        # Create a key based on item, unit, and preparation (if exists)
        key = (
            ingredient.item,
            ingredient.unit,
            ingredient.preparation,
            ingredient.category,
        )

        if key in combined:
            combined[key].amount += ingredient.amount
        else:
            # Create a new dictionary to avoid modifying the original
            combined[key] = ingredient.model_copy()

    return list(combined.values())
