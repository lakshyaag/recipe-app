# Python Backend

This directory contains the python backend for the recipe app.
It uses FastAPI to serve the API and LangGraph to orchestrate the recipe generation.

## How to run

### FastAPI

To run the FastAPI server, use the following command:

```bash
uvicorn src.api:app --reload
```

### LangGraph Server

To run the LangGraph server, use the following command:

```bash
python src/graph.py
```
