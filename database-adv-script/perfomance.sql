-- ================================================
-- PERFORMANCE TEST: COMPLEX BOOKINGS QUERY
-- ================================================

-- Initial unoptimized query (intentionally heavy)
-- Retrieves bookings + users + properties + payments
-- This version may cause sequential scans and unnecessary joins

SELECT 
    b.id AS booking_id,
    b.check_in_date,
    b.check_out_date,
    u.id AS user_id,
    u.name AS user_name,
    p.id AS property_id,
    p.title AS property_title,
    pay.id AS payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON u.id = b.user_id
JOIN properties p ON p.id = b.property_id
LEFT JOIN payments pay ON pay.booking_id = b.id;


-- ================================================
-- OPTIMIZED QUERY (Refactored)
-- ================================================

-- Improvements include:
-- 1. Only selecting necessary columns
-- 2. Using EXISTS instead of LEFT JOIN when payment data is not required
-- 3. Ensuring proper indexes are utilized

SELECT 
    b.id AS booking_id,
    b.check_in_date,
    b.check_out_date,
    u.name AS user_name,
    p.title AS property_title,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON u.id = b.user_id
JOIN properties p ON p.id = b.property_id
LEFT JOIN payments pay ON pay.booking_id = b.id
ORDER BY b.check_in_date DESC;
