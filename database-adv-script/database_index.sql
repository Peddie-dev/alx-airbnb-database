-- ==========================================
-- DATABASE INDEXES FOR AIRBNB CLONE BACKEND
-- ==========================================

-- ==========================================
-- 1. Measure performance BEFORE adding indexes
-- ==========================================
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'test@example.com';

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = 5;

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE check_in_date >= '2024-01-01';

EXPLAIN ANALYZE
SELECT * FROM properties WHERE city = 'Nairobi';

-- ==========================================
-- 2. CREATE INDEXES
-- ==========================================

-- USER TABLE INDEXES
CREATE INDEX IF NOT EXISTS idx_users_email
ON users(email);

CREATE INDEX IF NOT EXISTS idx_users_id
ON users(id);

-- BOOKINGS TABLE INDEXES
CREATE INDEX IF NOT EXISTS idx_bookings_user_id
ON bookings(user_id);

CREATE INDEX IF NOT EXISTS idx_bookings_check_in
ON bookings(check_in_date);

CREATE INDEX IF NOT EXISTS idx_bookings_property_id
ON bookings(property_id);

-- PROPERTIES TABLE INDEXES
CREATE INDEX IF NOT EXISTS idx_properties_city
ON properties(city);

CREATE INDEX IF NOT EXISTS idx_properties_price
ON properties(price);

CREATE INDEX IF NOT EXISTS idx_properties_id
ON properties(id);

-- REVIEWS TABLE INDEXES
CREATE INDEX IF NOT EXISTS idx_reviews_property_id
ON reviews(property_id);

CREATE INDEX IF NOT EXISTS idx_reviews_user_id
ON reviews(user_id);

-- PAYMENTS TABLE INDEXES
CREATE INDEX IF NOT EXISTS idx_payments_booking_id
ON payments(booking_id);

CREATE INDEX IF NOT EXISTS idx_payments_user_id
ON payments(user_id);

-- ==========================================
-- 3. Measure performance AFTER adding indexes
-- ==========================================
EXPLAIN ANALYZE
SELECT * FROM users WHERE email = 'test@example.com';

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE user_id = 5;

EXPLAIN ANALYZE
SELECT * FROM bookings WHERE check_in_date >= '2024-01-01';

EXPLAIN ANALYZE
SELECT * FROM properties WHERE city = 'Nairobi';
