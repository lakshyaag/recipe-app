from typing import TypedDict

from src.tools.recipe_tool import Recipe


class GraphState(TypedDict):
    url: str
    recipe: Recipe
