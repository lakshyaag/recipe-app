import os
from dotenv import load_dotenv
from typing import TypedDict, List

from langchain_core.messages import SystemMessage, HumanMessage
from langchain_openai import ChatOpenAI
from langgraph.graph import StateGraph, END, START
from langgraph.checkpoint.memory import MemorySaver
from langchain_core.documents import Document

from python_backend.utils.document_loader import get_recipe_from_url
from python_backend.utils.text_utils import sanitize_text
from python_backend.tools.recipe_tool import format_recipe

load_dotenv()

class Recipe(TypedDict):
    """Represents a simple recipe object."""
    title: str
    ingredients: List[str]
    instructions: List[str]


def process_recipe(url: str) -> Recipe:
    website_data = get_recipe_from_url(url)
    recipe = format_recipe(website_data)
    return recipe

def call_model(state):
    url = state['url']
    recipe = process_recipe(url)
    return {"recipe": recipe}

workflow = StateGraph()
workflow.add_node("recipe", call_model)
workflow.add_edge(START, "recipe")
workflow.set_entry_point("recipe")
workflow.add_edge("recipe", END)

checkpointer = MemorySaver()
app = workflow.compile(checkpointer=checkpointer)

if __name__ == "__main__":
    TEST_URL = "https://www.recipetineats.com/honey-garlic-chicken/"
    final_state = app.invoke(
        {"url": TEST_URL},
        config={"configurable": {"thread_id": 42}}
    )
    print(final_state["recipe"])
