from typing import Dict
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

from langgraph_sdk.client import get_client
import os


class RequestPayload(BaseModel):
    url: str


app = FastAPI(debug=True)


@app.post("/process")
async def process_url(request_payload: RequestPayload) -> Dict:
    """
    Accepts a URL and returns the output payload from processing it.
    """
    try:
        client = get_client(
            url="http://localhost:5001",
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

        return result

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
