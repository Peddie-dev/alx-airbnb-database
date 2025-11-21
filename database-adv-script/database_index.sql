-- ==========================================
-- DATABASE INDEXES FOR AIRBNB CLONE BACKEND
-- ==========================================

-- USER TABLE INDEXES
-- Index used for fast lookup of users during authentication
CREATE INDEX IF NOT EXISTS idx_users_email
ON users(email);

-- Index used for join operations between users and bookings
CREATE INDEX IF NOT EXISTS idx_users_id
ON users(id);

-------------------------------------------------

-- BOOKINGS TABLE INDEXES
-- Index used for retrieving all bookings made by a specific user
CREATE INDEX IF NOT EXISTS idx_bookings_user_id
ON bookings(user_id);

-- Index used for validating date conflicts or sorting by check-in date
CREATE INDEX IF NOT EXISTS idx_bookings_check_in
ON bookings(check_in_date);

-- Index used for sorting and filtering by property
CREATE INDEX IF NOT EXISTS idx_bookings_property_id
ON bookings(property_id);

-------------------------------------------------

-- PROPERTIES TABLE INDEXES
-- Index used for location-based filtering
CREATE INDEX IF NOT EXISTS idx_properties_city
ON properties(city);

-- Index used for pricing filters
CREATE INDEX IF NOT EXISTS idx_properties_price
ON properties(price);

-- Index used for faster joins between properties and bookings
CREATE INDEX IF NOT EXISTS idx_properties_id
ON properties(id);

-------------------------------------------------

-- REVIEWS TABLE INDEXES
-- Index used when retrieving reviews for a property
CREATE INDEX IF NOT EXISTS idx_reviews_property_id
ON reviews(property_id);

-- Index used when associating reviews to users
CREATE INDEX IF NOT EXISTS idx_reviews_user_id
ON reviews(user_id);

-------------------------------------------------

-- PAYMENTS TABLE INDEXES
-- Index used for retrieving payment history per booking
CREATE INDEX IF NOT EXISTS idx_payments_booking_id
ON payments(booking_id);

-- Index used for retrieving all payments made by a user
CREATE INDEX IF NOT EXISTS idx_payments_user_id
ON payments(user_id);
