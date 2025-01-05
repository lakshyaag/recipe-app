from typing import List
from langchain_community.document_loaders import WebBaseLoader
from langchain_core.documents import Document


def get_website_data(url: str) -> List[Document]:
    try:
        website_data = []
        loader = WebBaseLoader(url)
        website_data.extend(loader.load())
        return website_data
    
    except Exception as e:
        raise e
