from fastapi import APIRouter, Request
from fastapi.responses import JSONResponse
from .core import Processor

router = APIRouter()
processor = Processor()

@router.get("/health")
async def health_check():
    """Health check endpoint"""
    return JSONResponse(
        content={"status": "healthy", "service": "LLM Analytics API"},
        status_code=200
    )

@router.post("/analyze")
async def analyze_query(request: Request):
    """
    Analyze a single query for brand mentions
    """
    try:
        # Extract request data
        data = await request.json()
        query = data.get("query", "").strip()
        brand = data.get("brand")
        competitors = data.get("competitors", [])
        
        # Validate input
        if not query:
            return JSONResponse(
                content={"message": "Query cannot be empty"},
                status_code=400
            )
        
        if not brand:
            return JSONResponse(
                content={"message": "At least one brand must be provided"},
                status_code=400
            )
        
        # Process the query
        result = await processor.analyze_query(
            query=query,
            brand=brand,
            competitors=competitors
        )
        
        return JSONResponse(
            content=result,
            status_code=200
        )
        
    except Exception as e:
        return JSONResponse(
            content={"message": f"Analysis failed: {str(e)}"},
            status_code=500
        )
    