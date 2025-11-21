-- ============================================================
-- PARTITIONING THE BOOKINGS TABLE BY start_date (RANGE PARTITIONING)
-- ============================================================

-- 1. Rename the original table (if it exists)
ALTER TABLE bookings RENAME TO bookings_old;

-- 2. Create the new partitioned parent table
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
)
PARTITION BY RANGE (start_date);

-- 3. Create yearly partitions (example: 2023–2026)
CREATE TABLE bookings_2023 PARTITION OF bookings
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE bookings_2026 PARTITION OF bookings
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- 4. Insert data from old table into new partitioned structure
INSERT INTO bookings (id, user_id, property_id, start_date, end_date, status, created_at)
SELECT id, user_id, property_id, start_date, end_date, status, created_at
FROM bookings_old;

-- 5. Add indexes to partitions for better performance
CREATE INDEX idx_bookings_2023_start_date ON bookings_2023 (start_date);
CREATE INDEX idx_bookings_2024_start_date ON bookings_2024 (start_date);
CREATE INDEX idx_bookings_2025_start_date ON bookings_2025 (start_date);
CREATE INDEX idx_bookings_2026_start_date ON bookings_2026 (start_date);

-- 6. Optional: drop old table if everything is verified
-- DROP TABLE bookings_old;

