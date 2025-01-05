from src.utils.logger import logger
from typing import Dict
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

from src.utils.db_utils import SupabaseClient
from src.graph import graph


class RequestPayload(BaseModel):
    url: str


app = FastAPI(debug=True)


@app.get("/")
async def root():
    return {
        "message": "Welcome to the Recipe API. Please visit /docs for more information."
    }


# health check
@app.get("/ok")
async def ok():
    return {"message": "ok"}


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
        result = graph.invoke({"url": request_payload.url})

        if "recipe" not in result:
            raise HTTPException(
                status_code=500,
                detail="No recipe found. Please check the URL and try again.",
            )

        recipe_data = result["recipe"]

        # Store in database
        recipe_id = await db_client.insert_recipe(recipe_data, request_payload.url)

        # Return complete recipe data
        return {
            "recipe_id": recipe_id,
            "recipe": await db_client.get_recipe_by_id(recipe_id),
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
