from langchain_community.document_loaders import WebBaseLoader

def get_recipe_from_url(url: str) -> dict:
    website_data = []
    loader = WebBaseLoader(url)
    website_data.extend(loader.load())
    return website_data[0]
