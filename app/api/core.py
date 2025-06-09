from ..functions.detection_functions import DetectionFunctions
from ..functions.retrieval_functions import RetrievalFunctions

class Processor:
    def __init__(self):
        self.df = DetectionFunctions()
        self.rf = RetrievalFunctions()

    def analyze_query(self, query:str):
        pass