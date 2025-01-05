from typing import List
from langchain_core.messages import SystemMessage, HumanMessage
from langchain_openai import ChatOpenAI
from langchain_core.documents import Document
from src.schemas.recipe import Recipe
from src.utils.text_utils import sanitize_text


def format_recipe(website_data: List[Document]) -> Recipe:
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)
    messages = [
        SystemMessage(
            "Please extract recipes from the following website content. If a recipe is not found, return an empty recipe."
        ),
        HumanMessage(content=sanitize_text(website_data[0].page_content)),
    ]

    response = model.with_structured_output(Recipe).invoke(messages)
    return response
