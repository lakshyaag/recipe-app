import os
from typing import TypedDict, List
from langchain_core.messages import SystemMessage, HumanMessage
from langchain_openai import ChatOpenAI
from langchain_core.documents import Document

from python_backend.utils.text_utils import sanitize_text

class Recipe(TypedDict):
    """Represents a simple recipe object."""
    title: str
    ingredients: List[str]
    instructions: List[str]

def format_recipe(website_ Document) -> Recipe:
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    messages = [
        SystemMessage("Please extract recipes from the following website: "),
        HumanMessage(content=sanitize_text(website_data.page_content)),
    ]

    response = model.with_structured_output(Recipe).invoke(messages)
    return response
