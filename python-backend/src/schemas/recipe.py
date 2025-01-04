from typing import TypedDict, List


class Recipe(TypedDict):
    """Represents a simple recipe object."""

    title: str
    ingredients: List[str]
    instructions: List[str]
