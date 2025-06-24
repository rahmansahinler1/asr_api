from psycopg2 import extras
from psycopg2 import DatabaseError
from pathlib import Path
import psycopg2
import logging
import numpy as np
import uuid
from datetime import datetime

from .config import GenerateConfig

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class Database:
    _instance = None

    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(Database, cls).__new__(cls)
            cls._instance.db_config = GenerateConfig.config()
        return cls._instance

    def __enter__(self):
        self.conn = psycopg2.connect(**self.db_config)
        self.cursor = self.conn.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.cursor:
            self.cursor.close()
        if self.conn:
            if exc_type is None:
                self.conn.commit()
            else:
                self.conn.rollback()
            self.conn.close()

    def initialize_database(self):
        sql_path = Path(__file__).resolve().parent / "sql" / "initialize_database.sql"
        with sql_path.open("r") as file:
            query = file.read()
        try:
            self.cursor.execute(query)
            self.conn.commit()
        except DatabaseError as e:
            self.conn.rollback()
            raise e
    
    def insert_test_users(self):
        sql_path = Path(__file__).resolve().parent / "sql" / "insert_test_data.sql"
        with sql_path.open("r") as file:
            query = file.read()
        try:
            self.cursor.execute(query)
            self.conn.commit()
        except DatabaseError as e:
            self.conn.rollback()
            raise e

    def reset_database(self):
        sql_path = Path(__file__).resolve().parent / "sql" / "reset_database.sql"
        with sql_path.open("r") as file:
            query = file.read()
        try:
            self.cursor.execute(query)
            self.conn.commit()
        except DatabaseError as e:
            self.conn.rollback()
            raise e

    # 🆕 Individual data retrieval functions
    def get_user_info(self, user_id):
        """Get user information by user_id"""
        try:
            query = """
                SELECT user_id, user_name, user_surname, user_email, user_type, user_created_at
                FROM user_info 
                WHERE user_id = %s
            """
            self.cursor.execute(query, (user_id,))
            result = self.cursor.fetchone()
            
            if result:
                return {
                    "user_id": str(result[0]),
                    "user_name": result[1],
                    "user_surname": result[2], 
                    "user_email": result[3],
                    "user_type": result[4],
                    "user_created_at": result[5].isoformat() if result[5] else None
                }
            return None
            
        except DatabaseError as e:
            logger.error(f"Error fetching user info: {e}")
            raise e

    def get_brand_info(self, user_id):
        """Get brand information for a user (single brand)"""
        try:
            query = """
                SELECT brand_id, brand_name, domain, brand_niches, last_update
                FROM brand_info 
                WHERE user_id = %s
                LIMIT 1
            """
            self.cursor.execute(query, (user_id,))
            result = self.cursor.fetchone()
            
            if result:
                return {
                    "brand_id": str(result[0]),
                    "brand_name": result[1],
                    "domain": result[2],
                    "brand_niches": result[3],
                    "last_update": result[4].isoformat() if result[4] else None
                }
            return None
            
        except DatabaseError as e:
            logger.error(f"Error fetching brand info: {e}")
            raise e

    def get_overview_data(self, user_id):
        """Get overview/analytics data for a user with previous score and change calculation"""
        try:
            query = """
                SELECT o.overview_id, o.brand_id, o.created_at, o.ai_seo_score,
                       b.brand_name
                FROM overview_data o
                JOIN brand_info b ON o.brand_id = b.brand_id
                WHERE o.user_id = %s
                ORDER BY o.created_at DESC
            """
            self.cursor.execute(query, (user_id,))
            results = self.cursor.fetchall()
            
            overview_data = []
            score_change_percent = 0
            if len(results) > 1:
                score_change_percent = round(((results[0][3] - results[1][3]) / results[1][3]) * 100, 1)
            else:
                score_change_percent = -101
                
            overview_data.append({
                "overview_id": str(results[0][0]),
                "brand_id": str(results[0][1]),
                "created_at": results[0][2].isoformat() if results[0][2] else None,
                "ai_seo_score": results[0][3],
                "brand_name": results[0][4],
                "score_change_percent": score_change_percent,
            })
            
            return overview_data
            
        except DatabaseError as e:
            logger.error(f"Error fetching overview data: {e}")
            raise e

    # 🆕 Wrapper function for initialization endpoint
    def get_init_data(self, user_id):
        """Get all initialization data for a user (user_info, brand_info, overview_data)"""
        try:
            # Get all three data sets
            user_info = self.get_user_info(user_id)
            brand_info = self.get_brand_info(user_id) 
            overview_data = self.get_overview_data(user_id)
            
            return user_info, brand_info, overview_data
            
        except DatabaseError as e:
            logger.error(f"Error in get_init_data: {e}")
            raise e

if __name__ == "__main__":
    # For development: Full reset + initialize + test data
    print("🔄 Full development setup...")
    with Database() as db:
        db.reset_database()
        db.initialize_database()
        db.insert_test_users()
    print("✅ Development database ready!")
        