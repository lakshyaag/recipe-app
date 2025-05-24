from typing import List, Literal, Optional, Union
from pydantic import BaseModel, Field


class Ingredient(BaseModel):
    """
    Represents an ingredient in a recipe.
    """

    item: str = Field(..., description="The name of the ingredient")
    amount: Union[float, int] = Field(..., description="The quantity of the ingredient")
    unit: str = Field(..., description="Unit of measurement")

    category: Literal[
        "protein",
        "grains",
        "produce",
        "oils",
        "condiments",
        "spices",
        "sauces",
        "dairy",
        "herbs",
        "other",
    ] = Field(default="other", description="High-level category for grouping")

    preparation: Optional[str] = Field(
        None, description="Preparation instructions (e.g., crushed, julienned)"
    )

    is_optional: bool = Field(
        default=False, description="Whether ingredient is optional"
    )

    notes: Optional[str] = Field(
        None, description="Additional notes about the ingredient"
    )


class Time(BaseModel):
    """
    Represents the time needed in a recipe.
    # TODO: This will eventually map to a time UI component in the frontend
    """

    amount: Union[float, int] = Field(..., description="The quantity of time needed")
    unit: str = Field(..., description="The unit of measurement for the time")


class Instruction(BaseModel):
    """
    Represents a cooking instruction in a recipe.
    """

    step: int = Field(..., description="The step number in the instruction sequence")
    description: str = Field(..., description="The description of the instruction")
    time: Optional[Time] = Field(
        None, description="The time specified in the instruction"
    )


class ServingSize(BaseModel):
    """
    Represents the serving size of a recipe.
    """

    amount: Union[float, int] = Field(
        ..., description="The quantity of the serving size"
    )
    unit: str = Field(..., description="The unit of measurement for the serving size")


class Recipe(BaseModel):
    """Represents a simple recipe object."""

    title: str = Field(..., description="The name of the recipe")
    servings: ServingSize = Field(
        ..., description="The number of servings the recipe makes"
    )
    cookTime: Optional[Time] = Field(None, description="The cook time for the recipe")
    difficulty: Literal["novice", "home_cook", "professional_chef", "other"] = Field(
        ..., description="The difficulty of the recipe"
    )
    ingredients: List[Ingredient] = Field(
        ..., description="The ingredients needed for the recipe"
    )
    instructions: List[Instruction] = Field(
        ..., description="The instructions for the recipe"
    )
