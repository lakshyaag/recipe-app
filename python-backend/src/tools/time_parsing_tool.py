from typing import List
from langchain_openai import ChatOpenAI
from pydantic import BaseModel, Field
from src.schemas.recipe import InstructionWithTime, Recipe
from langchain_core.messages import SystemMessage, HumanMessage, AIMessage
from pydantic_core import to_jsonable_python
import json


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
            "From the provided recipe, please inspect each instruction item for things that might indicate time. If you find any, please return the updated recipe with the time added."
        ),
        AIMessage(content=json.dumps(to_jsonable_python(recipe))),
        HumanMessage(content=instructions),
    ]

    response = model.with_structured_output(Response).invoke(messages)

    recipe.instructions = response.instructions_with_time

    return recipe
