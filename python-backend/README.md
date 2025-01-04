# Recipe App Python Backend

This directory contains the Python backend for the Recipe App. It provides:

- A LangGraph implementation for orchestrating the recipe generation process.
- A FastAPI-based API for serving recipe data.

## Getting Started

### Prerequisites

- Python 3.12 or higher
- uv (or pip) for package management

### Installation

1. Navigate to the `python-backend` directory.
2. Install the required dependencies using `uv sync`

### Running the Application

#### FastAPI Server

To start the FastAPI server, execute the following command:

```bash
uv run fastapi dev src/api.py
```

This will start the server with hot reloading enabled, making it suitable for development.

#### LangGraph Server

To run the LangGraph server, use the following command:

```bash
source .venv/bin/activate
langgraph dev
```

This will start the LangGraph server, which is responsible for generating recipes.
