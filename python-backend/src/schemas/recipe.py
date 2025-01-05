from typing import List, Literal, Optional
from pydantic import BaseModel, Field


class Ingredient(BaseModel):
    """
    Represents an ingredient in a recipe.
    """

    item: str = Field(..., description="The name of the ingredient.")
    amount: float = Field(..., description="The quantity of the ingredient")
    unit: str = Field(..., description="The unit of measurement for the ingredient")
    notes: Optional[str] = Field(
        None, description="Any additional notes about the ingredient"
    )


class Time(BaseModel):
    """
    Represents the time needed in a recipe.
    # TODO: This will eventually map to a time UI component in the frontend
    """

    amount: float = Field(..., description="The quantity of time needed")
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


class Recipe(BaseModel):
    """Represents a simple recipe object."""

    title: str = Field(..., description="The name of the recipe")
    servings: int = Field(..., description="The number of servings the recipe makes")
    ingredients: List[Ingredient] = Field(
        ..., description="The ingredients needed for the recipe"
    )
    instructions: List[Instruction] = Field(
        ..., description="The instructions for the recipe"
    )
    cookTime: Optional[Time] = Field(None, description="The cook time for the recipe")
    difficulty: Literal["novice", "home_cook", "professional_chef"] = Field(
        ..., description="The difficulty of the recipe"
    )
