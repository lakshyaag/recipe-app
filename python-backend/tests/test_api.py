import pytest
from fastapi.testclient import TestClient
from src.api import app


@pytest.fixture
def test_client():
    return TestClient(app)


@pytest.mark.asyncio
async def test_process_url_success(test_client):
    response = test_client.post(
        "/process",
        json={"url": "https://www.allrecipes.com/recipe/21371/basic-pancakes/"},
    )
    print(response.json())
    assert response.status_code == 200
    assert "recipe" in response.json()


@pytest.mark.asyncio
async def test_process_url_failure(test_client):
    response = test_client.post(
        "/process",
        json={"url": "invalid_url"},
    )

    assert response.status_code == 500
    assert "No recipe found" in response.json()["detail"]
