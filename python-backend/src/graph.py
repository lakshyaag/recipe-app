from langgraph.graph import StateGraph, END, START

from src.utils.cleanup import combine_ingredients
from src.utils.logger import logger
from src.utils.document_loader import get_website_data
from src.tools.recipe_tool import format_recipe
from src.schemas.state import GraphState


def parse_link(state: GraphState) -> GraphState:
    try:
        url = state["url"]
        logger.info("Parsing link: %s", url)
        website_data = get_website_data(url)

        return {"website_data": website_data}

    except Exception as e:
        raise e


def process_recipe(state: GraphState) -> GraphState:
    website_data = state["website_data"]
    try:
        if not website_data:
            raise ValueError("No website data found")

        recipe = format_recipe(website_data)

        # Combine all ingredients with the same name, unit, and preparation
        recipe.ingredients = combine_ingredients(recipe.ingredients)
        return {"recipe": recipe}

    except Exception as e:
        raise e


workflow = StateGraph(GraphState)
workflow.add_node("parse_link", parse_link)
workflow.add_node("process_recipe", process_recipe)
workflow.add_edge(START, "parse_link")
workflow.add_edge("parse_link", "process_recipe")
workflow.add_edge("process_recipe", END)
workflow.set_entry_point("parse_link")

graph = workflow.compile()
graph.name = "Recipe Graph"
