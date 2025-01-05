from typing import List, TypedDict

from src.tools.recipe_tool import Recipe
from langchain_core.documents import Document

class GraphState(TypedDict):
    url: str
    website_data: List[Document]
    recipe: Recipe
