-- Test data for AI SEO Score Change Indicator functionality
-- This script creates 4 test users with different scenarios:
-- 1. Sarah Newbie: Not enough data (only 1 record) -> returns -101
-- 2. John Increase: Score increased (60 -> 75) -> positive percentage  
-- 3. Mike Decline: Score decreased (80 -> 65) -> negative percentage
-- 4. Emma Stable: Score unchanged (70 -> 70) -> 0 percentage

-- Insert test users
INSERT INTO user_info (user_id, user_name, user_surname, user_email, user_type) VALUES
('00000000-0000-0000-0000-000000000001', 'Sarah', 'Newbie', 'sarah.newbie@test.com', 'standard'),
('00000000-0000-0000-0000-000000000002', 'John', 'Increase', 'john.increase@test.com', 'standard'),
('00000000-0000-0000-0000-000000000003', 'Mike', 'Decline', 'mike.decline@test.com', 'standard'),
('00000000-0000-0000-0000-000000000004', 'Emma', 'Stable', 'emma.stable@test.com', 'standard');

-- Insert brand information for each user
INSERT INTO brand_info (brand_id, user_id, brand_name, domain, brand_niches) VALUES
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Startup Co', 'startup.co', ARRAY['Technology', 'Innovation']),
('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', 'Growth Tech', 'growthtech.com', ARRAY['SaaS', 'Analytics']),
('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000003', 'Falling Inc', 'falling.inc', ARRAY['Retail', 'E-commerce']),
('10000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000004', 'Steady Corp', 'steady.corp', ARRAY['Finance', 'Consulting']);

-- Insert overview data for testing different scenarios
-- User 1 (Sarah Newbie): Only 1 record -> triggers -101 "Not enough data collected"
INSERT INTO overview_data (overview_id, user_id, brand_id, created_at, ai_seo_score) VALUES
('20000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', NOW(), 55);

-- User 2 (John Increase): 2 records showing increase (60 -> 75) = +25%
INSERT INTO overview_data (overview_id, user_id, brand_id, created_at, ai_seo_score) VALUES
('20000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', NOW() - INTERVAL '1 week', 60),
('20000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', NOW(), 75);

-- User 3 (Mike Decline): 2 records showing decrease (80 -> 65) = -18.8%
INSERT INTO overview_data (overview_id, user_id, brand_id, created_at, ai_seo_score) VALUES
('20000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000003', NOW() - INTERVAL '1 week', 80),
('20000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000003', NOW(), 65);

-- User 4 (Emma Stable): 2 records showing no change (70 -> 70) = 0%
INSERT INTO overview_data (overview_id, user_id, brand_id, created_at, ai_seo_score) VALUES
('20000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000004', NOW() - INTERVAL '1 week', 70),
('20000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000004', NOW(), 70);