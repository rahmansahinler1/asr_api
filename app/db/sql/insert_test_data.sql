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

-- Insert brand information for each user with 10 niches
INSERT INTO brand_info (brand_id, user_id, brand_name, domain, brand_niches) VALUES
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', 'Startup Co', 'startup.co', ARRAY['Cost', 'Efficiency', 'Privacy', 'UX', 'No Code', 'Fast Setup', 'AI Powered', 'Security', 'Integration', 'Support']),
('10000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', 'Growth Tech', 'growthtech.com', ARRAY['Cost', 'Efficiency', 'Privacy', 'UX', 'No Code', 'Fast Setup', 'AI Powered', 'Security', 'Integration', 'Support']),
('10000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000003', 'Falling Inc', 'falling.inc', ARRAY['Cost', 'Efficiency', 'Privacy', 'UX', 'No Code', 'Fast Setup', 'AI Powered', 'Security', 'Integration', 'Support']),
('10000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000004', 'Steady Corp', 'steady.corp', ARRAY['Cost', 'Efficiency', 'Privacy', 'UX', 'No Code', 'Fast Setup', 'AI Powered', 'Security', 'Integration', 'Support']);

-- Insert overview data for testing different scenarios
-- User 1 (Sarah Newbie): Only 1 record -> triggers -101 "Not enough data collected"
INSERT INTO overview_data (overview_id, user_id, brand_id, created_at, ai_seo_score, crawlability_score, total_reference_mention, total_link_mention) VALUES
('20000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', NOW(), 55, ARRAY[120, 30, 15, 5], ARRAY[2, 3, 1, 4, 2, 1, 3, 2, 1, 2], ARRAY[1, 2, 2, 3, 1, 2, 1, 1, 3, 1]);

-- User 2 (John Increase): AI SEO increase (60 -> 75) = +25%, Crawlability +10 well performing (140 -> 150), Total mentions increase
INSERT INTO overview_data (overview_id, user_id, brand_id, created_at, ai_seo_score, crawlability_score, total_reference_mention, total_link_mention) VALUES
('20000000-0000-0000-0000-000000000002', '00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', NOW() - INTERVAL '1 week', 60, ARRAY[140, 35, 18, 7], ARRAY[1, 2, 2, 5, 2, 1, 1, 2, 1, 3], ARRAY[1, 2, 3, 1, 2, 1, 1, 1, 2, 1]),
('20000000-0000-0000-0000-000000000003', '00000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000002', NOW(), 75, ARRAY[150, 30, 15, 5], ARRAY[2, 3, 3, 6, 3, 2, 2, 3, 2, 4], ARRAY[2, 3, 4, 2, 3, 2, 2, 2, 3, 2]);

-- User 3 (Mike Decline): AI SEO decrease (80 -> 65) = -18.8%, Crawlability -5 well performing (155 -> 150), Total mentions decrease
INSERT INTO overview_data (overview_id, user_id, brand_id, created_at, ai_seo_score, crawlability_score, total_reference_mention, total_link_mention) VALUES
('20000000-0000-0000-0000-000000000004', '00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000003', NOW() - INTERVAL '1 week', 80, ARRAY[155, 25, 15, 5], ARRAY[3, 4, 4, 7, 3, 2, 3, 4, 3, 5], ARRAY[2, 4, 5, 3, 4, 3, 3, 3, 4, 3]),
('20000000-0000-0000-0000-000000000005', '00000000-0000-0000-0000-000000000003', '10000000-0000-0000-0000-000000000003', NOW(), 65, ARRAY[150, 30, 15, 5], ARRAY[2, 3, 3, 5, 2, 1, 2, 3, 2, 4], ARRAY[1, 3, 4, 2, 3, 2, 2, 2, 3, 2]);

-- User 4 (Emma Stable): AI SEO no change (70 -> 70) = 0%, Crawlability no change (150 -> 150), Total mentions no change
INSERT INTO overview_data (overview_id, user_id, brand_id, created_at, ai_seo_score, crawlability_score, total_reference_mention, total_link_mention) VALUES
('20000000-0000-0000-0000-000000000006', '00000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000004', NOW() - INTERVAL '1 week', 70, ARRAY[150, 30, 15, 5], ARRAY[2, 3, 3, 5, 2, 2, 2, 3, 2, 3], ARRAY[1, 2, 3, 2, 2, 2, 2, 2, 2, 2]),
('20000000-0000-0000-0000-000000000007', '00000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000004', NOW(), 70, ARRAY[150, 30, 15, 5], ARRAY[2, 3, 3, 5, 2, 2, 2, 3, 2, 3], ARRAY[1, 2, 3, 2, 2, 2, 2, 2, 2, 2]);