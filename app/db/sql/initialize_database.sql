CREATE TABLE IF NOT EXISTS waitlist_info (
    user_email VARCHAR(100) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS wishlist_info (
    user_email VARCHAR(100) PRIMARY KEY,
    user_name VARCHAR(50),
    user_surname VARCHAR(50),
    user_message VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
