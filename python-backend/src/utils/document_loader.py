from typing import List
from src.utils.logger import logger
from langchain_community.document_loaders import WebBaseLoader
from langchain_core.documents import Document


def get_website_data(url: str) -> List[Document]:
    try:
        logger.info("Loading website data from URL: %s", url)
        website_data = []
        loader = WebBaseLoader(url)
        website_data.extend(loader.load())
        return website_data

    except Exception as e:
        raise e
