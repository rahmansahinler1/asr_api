#!/usr/bin/env python3
"""
Database Initialize Script
Usage: python -m app.db.initialize
"""

from .database import Database

if __name__ == "__main__":
    print("🏗️  Initializing database schema...")
    with Database() as db:
        db.initialize_database()
    print("✅ Database schema initialized!")