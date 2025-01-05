from src.utils.logger import logger
from typing import Dict
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

from src.utils.db_utils import SupabaseClient
from src.schemas.recipe import Recipe
from langgraph_sdk.client import get_client
import os


class RequestPayload(BaseModel):
    url: str


app = FastAPI(debug=True)


@app.get("/")
async def root():
    return {
        "message": "Welcome to the Recipe API. Please visit /docs for more information."
    }


@app.post("/process")
async def process_url(request_payload: RequestPayload) -> Dict:
    """
    Checks if the recipe already exists in database.
    Accepts a URL and returns the output payload from processing it.
    """
    db_client = SupabaseClient()
    url_hash = db_client.create_url_hash(request_payload.url)

    logger.info("Processing URL: %s", request_payload.url)
    # # Check if recipe exists
    existing_recipe_id = await db_client.get_existing_recipe(url_hash)
    if existing_recipe_id:
        recipe_data = await db_client.get_recipe_by_id(existing_recipe_id)
        return {"recipe_id": existing_recipe_id, "recipe": recipe_data}

    try:
        client = get_client(
            url="http://127.0.0.1:5001",
            api_key=os.environ.get("LANGCHAIN_API_KEY"),
        )

        thread = await client.threads.create(
            metadata={
                "user_agent": os.environ.get("USER_AGENT"),
            }
        )

        run = await client.runs.create(
            assistant_id="agent",
            thread_id=thread["thread_id"],
            input={"url": request_payload.url},
        )

        result = await client.runs.join(
            thread_id=thread["thread_id"],
            run_id=run["run_id"],
        )

        if "recipe" not in result:
            raise HTTPException(
                status_code=500,
                detail="No recipe found. Please check the URL and try again.",
            )

        recipe_data = result["recipe"]
        recipe = Recipe(**recipe_data)

        # Store in database
        recipe_id = await db_client.insert_recipe(recipe, request_payload.url)

        # Return complete recipe data
        return {
            "recipe_id": recipe_id,
            "recipe": await db_client.get_recipe_by_id(recipe_id),
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
