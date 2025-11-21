-- ============================================================
-- PERFORMANCE TEST: COMPLEX BOOKINGS QUERY
-- ============================================================

-- Initial unoptimized query (includes WHERE/AND clauses)
-- Retrieves bookings + users + properties + payments for active bookings in 2024
EXPLAIN ANALYZE
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
LEFT JOIN payments pay ON pay.booking_id = b.id
WHERE b.check_in_date >= '2024-01-01' AND b.check_out_date <= '2024-12-31';

-- ============================================================
-- OPTIMIZED QUERY (Refactored)
-- ============================================================

-- 1. Only necessary columns
-- 2. Use indexes for WHERE clause filtering
EXPLAIN ANALYZE
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
WHERE b.check_in_date >= '2024-01-01' AND b.check_out_date <= '2024-12-31'
ORDER BY b.check_in_date DESC;
