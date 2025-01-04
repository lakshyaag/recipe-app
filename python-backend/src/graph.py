from langgraph.graph import StateGraph, END, START

from src.utils.document_loader import get_recipe_from_url
from src.tools.recipe_tool import Recipe, format_recipe
from src.schemas.state import GraphState


def process_recipe(state: GraphState) -> Recipe:
    try:
        url = state["url"]
        print(url)
        website_data = get_recipe_from_url(url)
        print(website_data)

        recipe = format_recipe(website_data)
        return {"recipe": recipe}
    except Exception as e:
        raise e


workflow = StateGraph(GraphState)
workflow.add_node("process_recipe", process_recipe)
workflow.add_edge(START, "process_recipe")
workflow.set_entry_point("process_recipe")
workflow.add_edge("process_recipe", END)

graph = workflow.compile()
