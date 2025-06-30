CREATE TABLE IF NOT EXISTS user_info (
    user_id UUID PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL,
    user_surname VARCHAR(50) NOT NULL,
    user_email VARCHAR(100) UNIQUE NOT NULL,
    user_type VARCHAR(20) NOT NULL,
    user_created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS brand_info (
    brand_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    brand_name VARCHAR(50) NOT NULL,
    domain VARCHAR(100) NOT NULL,
    brand_niches TEXT[] NOT NULL,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_info(user_id)
);

CREATE TABLE IF NOT EXISTS overview_data (
    overview_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    brand_id UUID NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ai_seo_score INTEGER CHECK (ai_seo_score >= 0 AND ai_seo_score <= 100),
    crawlability_score INTEGER[] CHECK (array_length(crawlability_score, 1) = 4),
    total_reference_mention INTEGER[] CHECK (array_length(total_reference_mention, 1) = 10),
    total_link_mention INTEGER[] CHECK (array_length(total_link_mention, 1) = 10),
    FOREIGN KEY (user_id) REFERENCES user_info(user_id),
    FOREIGN KEY (brand_id) REFERENCES brand_info(brand_id)
);