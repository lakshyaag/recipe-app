from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

from langgraph_sdk.client import get_client
import os

from src.schemas.state import GraphState


class URLInput(BaseModel):
    url: str


app = FastAPI(debug=True)


@app.post("/process")
async def process_url(url_input: URLInput) -> GraphState:
    """
    Accepts a URL and returns the output payload from processing it.
    """
    try:
        client = get_client(
            url="http://localhost:5001",
            api_key=os.environ.get("LANGCHAIN_API_KEY"),
        )

        thread = await client.threads.create()

        run = await client.runs.create(
            thread_id=thread.thread_id,
            assistant_id="default",
            input={"url": url_input.url},
        )

        result = await client.runs.join(
            thread_id=thread.thread_id,
            run_id=run.run_id,
        )

        return result

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
