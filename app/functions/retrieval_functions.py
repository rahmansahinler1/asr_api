from openai import OpenAI
from datetime import datetime
import os

class RetrievalFunctions:
    def __init__(self):
        self.client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

    def search_web(self, query):
        try:
            response = self.client.chat.completions.create(
                model="gpt-4o-search-preview",
                web_search_options={"search_context_size": "medium"},
                messages=[{"role": "user", "content": query}]
            )
            
            # Plain answer
            answer = response.choices[0].message.content

            # URLs
            urls = []
            for annotation in response.choices[0].message.annotations:
                url = annotation.url_citation.url
                if url not in urls:
                    urls.append(url)
                
            # Date
            date = str(datetime.fromtimestamp(response.created)).split(" ")[0]
            
            return answer, urls, date
            
        except Exception as e:
            print(f"OpenAI API error: {str(e)}")
            raise Exception(f"Failed to retrieve LLM response: {str(e)}")
