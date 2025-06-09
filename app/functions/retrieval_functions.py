from openai import OpenAI
from dotenv import load_dotenv
import os


class RetrievalFunctions:
    def __init__(self):
        load_dotenv()
        self.client = OpenAI()

    def search_web(self, query:str):
        """Web search function"""
        pass
