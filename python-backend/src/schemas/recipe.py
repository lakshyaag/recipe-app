from typing import TypedDict, List, Optional


class Recipe(TypedDict):
    """Represents a simple recipe object."""

    title: str
    ingredients: List[str]
    instructions: List[str]
    # Add these optional fields:
    cookTime: Optional[str]
    difficulty: Optional[str]
