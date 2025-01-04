import pytest
from fastapi.testclient import TestClient
from ..src.api import app
from unittest.mock import patch

@pytest.fixture
def test_client():
    return TestClient(app)


@pytest.mark.asyncio
async def test_process_url_success(test_client):
    with patch("python_backend.src.api.get_client") as mock_get_client:
        mock_client = mock_get_client.return_value
        mock_client.threads.create.return_value = {"thread_id": "test_thread_id"}
        mock_client.runs.create.return_value = {"run_id": "test_run_id"}
        mock_client.runs.join.return_value = {
            "status": "completed",
            "output": {"key": "value"},
        }

        response = test_client.post(
            "/process",
            json={"url": "https://example.com"},
        )
        assert response.status_code == 200
        assert response.json() == {"status": "completed", "output": {"key": "value"}}


@pytest.mark.asyncio
async def test_process_url_failure(test_client):
    with patch("python_backend.src.api.get_client") as mock_get_client:
        mock_get_client.side_effect = Exception("Test Exception")
        response = test_client.post(
            "/process",
            json={"url": "https://example.com"},
        )
        assert response.status_code == 500
        assert "Test Exception" in response.json()["detail"]
