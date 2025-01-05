from typing import List
from src.utils.logger import logger
from langchain_openai import ChatOpenAI
from pydantic import BaseModel, Field
from src.schemas.recipe import InstructionWithTime, Recipe
from langchain_core.messages import SystemMessage, HumanMessage, AIMessage
from pydantic_core import to_jsonable_python
import json
from textwrap import dedent


class Response(BaseModel):
    instructions_with_time: List[InstructionWithTime] = Field(
        ..., description="The instructions for the recipe with time"
    )


def parse_instruction_times(recipe: Recipe) -> Recipe:
    """
    Examine each instruction in the recipe for time indications
    and enrich/return the updated recipe as needed.
    """
    model = ChatOpenAI(model="gpt-4o-mini", temperature=0)

    instructions = json.dumps(
        to_jsonable_python(
            recipe.instructions,
        )
    )

    messages = [
        SystemMessage(
            dedent(
                """
                From the provided recipe, please inspect each instruction and identify the time that is specified.

                If a time range is specified, please convert it to an appropriate single time value.
                """
            )
        ),
        AIMessage(content=json.dumps(to_jsonable_python(recipe))),
        HumanMessage(content=instructions),
    ]

    logger.info("Parsing instruction times for recipe")
    response = model.with_structured_output(Response).invoke(messages)

    recipe.instructions = response.instructions_with_time

    return recipe
