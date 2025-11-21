-- ============================================================
-- 1. AGGREGATION QUERY: Total number of bookings per user
-- ============================================================

SELECT
    u.id AS user_id,
    u.name AS user_name,
    COUNT(b.id) AS total_bookings
FROM users u
LEFT JOIN bookings b
    ON u.id = b.user_id
GROUP BY u.id, u.name
ORDER BY total_bookings DESC;


-- ============================================================
-- 2. WINDOW FUNCTION QUERY: Rank properties using ROW_NUMBER()
-- ============================================================

SELECT
    p.id AS property_id,
    p.title AS property_title,
    COUNT(b.id) AS total_bookings,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.id) DESC) AS row_number_rank
FROM properties p
LEFT JOIN bookings b
    ON p.id = b.property_id
GROUP BY p.id, p.title
ORDER BY row_number_rank;


-- ============================================================
-- 3. WINDOW FUNCTION QUERY: Rank properties using RANK()
-- ============================================================

SELECT
    p.id AS property_id,
    p.title AS property_title,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS rank
FROM properties p
LEFT JOIN bookings b
    ON p.id = b.property_id
GROUP BY p.id, p.title
ORDER BY rank;
