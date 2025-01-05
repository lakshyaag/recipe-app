from langgraph.graph import StateGraph, END, START

from src.utils.document_loader import get_website_data
from src.tools.recipe_tool import format_recipe
from src.tools.time_parsing_tool import parse_instruction_times
from src.schemas.state import GraphState


def parse_link(state: GraphState) -> GraphState:
    try:
        url = state["url"]
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
        return {"recipe": recipe}

    except Exception as e:
        raise e


def break_down_time(state: GraphState) -> GraphState:
    recipe = state["recipe"]

    try:
        if not recipe:
            raise ValueError("No recipe found")

        updated_recipe = parse_instruction_times(recipe)
        return {"recipe": updated_recipe}

    except Exception as e:
        raise e


workflow = StateGraph(GraphState)
workflow.add_node("parse_link", parse_link)
workflow.add_node("process_recipe", process_recipe)
workflow.add_node("break_down_time", break_down_time)
workflow.add_edge(START, "parse_link")
workflow.add_edge("parse_link", "process_recipe")
workflow.add_edge("process_recipe", "break_down_time")
workflow.add_edge("break_down_time", END)
workflow.set_entry_point("parse_link")

graph = workflow.compile()
