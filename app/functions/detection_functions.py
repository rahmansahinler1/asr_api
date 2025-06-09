class DetectionFunctions:
    def direct_detection(self, answer:str, brand:str, competitors:list[str]):
        detection_matrix = {}
        all_brands = competitors + [brand]
        lower_answer = answer.lower()
        for b in all_brands:
            detection_matrix[b] = lower_answer.count(b.lower())

        return detection_matrix