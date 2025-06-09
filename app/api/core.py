from app.functions.retrieval_functions import RetrievalFunctions
from app.functions.detection_functions import DetectionFunctions

class Processor:
    def __init__(self):
        self.rf = RetrievalFunctions()
        self.df = DetectionFunctions()
        self.cost_per_query = 0.035
    
    def analyze_query(self, query: str, brand: str, competitors: list):
        try:
            answer, urls, date = self.rf.search_web(query)
            detections = self.df.direct_detection(answer=answer, brand=brand, competitors=competitors)

            
            return {
                "detections": detections,
                "resources": urls,
                "date": date
            }
            
        except Exception as e:
            return {
                "error": True,
                "message": f"Analysis failed: {str(e)}",
                "query": query
            }
