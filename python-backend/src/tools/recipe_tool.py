from typing import List
from src.utils.logger import logger
from langchain_core.messages import SystemMessage, HumanMessage
from langchain_openai import ChatOpenAI
from langchain_core.documents import Document
from src.schemas.recipe import Recipe
from src.utils.text_utils import sanitize_text
from textwrap import dedent


def format_recipe(website_data: List[Document]) -> Recipe:
    model = ChatOpenAI(
        model="gpt-4.1",
        temperature=0.1,
    )
    messages = [
        SystemMessage(
            dedent(
                """
                Please extract the recipe from the following website content. Include the serving size and unit of measurement.
                If a recipe is not found, return an empty recipe.

                For each instruction, include the time if it is specified. 
                If a time range is specified, use the lower bound of the range as the time.

                For each ingredient, include the category of the ingredient as one of: [protein, grains, produce, oils, condiments, spices, sauces, dairy, herbs, other].
                Ensure that each ingredient's preparation method is included if available.
                """
            )
        ),
        HumanMessage(content=sanitize_text(website_data[0].page_content)),
    ]

    logger.info("Formatting recipe from website data")
    response = model.with_structured_output(Recipe).invoke(messages)
    return response
