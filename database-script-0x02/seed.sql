--
-- SQL Script for populating the database with sample data (seed.sql)
-- Note: This script assumes the schema.sql has been executed, creating the necessary tables and ENUM types.
-- All UUIDs are hardcoded for consistent foreign key referencing.
--

-- ====================================================================
-- 1. Sample UUIDs for easy referencing
-- ====================================================================

-- Users
-- 3cfb57f0-282e-4b47-b8a7-7e61a29f3480 (Admin)
-- 9d64a852-3d7c-474c-8f1d-230d42129c50 (Host: Alex Johnson)
-- 5a73e160-5a3d-4c91-9e8a-867c4f4b9012 (Guest: Maria Garcia)

-- Properties
-- 1f3e7920-5c6a-4d1e-8b0c-9a2f1c8d3b4a (Property 1: Cozy Cabin)
-- 8c4f2b1a-0a7e-4f3c-9d5b-1e6a7c4f9d2b (Property 2: Downtown Loft)

-- Bookings
-- a1b2c3d4-e5f6-7890-1234-567890abcdef (Confirmed Booking)
-- ffeddcba-9876-5432-10fe-dcba98765432 (Canceled Booking)

-- Payments
-- 67890abc-def0-1234-5678-90abcdef1234 (Payment for Confirmed Booking)

-- Reviews
-- 0fedcba9-8765-4321-fedc-ba9876543210 (Review of Cozy Cabin)

-- Messages
-- 11111111-2222-3333-4444-555555555555 (Host to Guest)
-- 22222222-3333-4444-5555-666666666666 (Guest to Host)

-- ====================================================================
-- 2. User Data
-- ====================================================================

INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('3cfb57f0-282e-4b47-b8a7-7e61a29f3480', 'Admin', 'User', 'admin@bnb.com', 'hashed_admin_pass', NULL, 'admin'),
('9d64a852-3d7c-474c-8f1d-230d42129c50', 'Alex', 'Johnson', 'alex.host@email.com', 'hashed_host_pass', '555-1234', 'host'),
('5a73e160-5a3d-4c91-9e8a-867c4f4b9012', 'Maria', 'Garcia', 'maria.guest@email.com', 'hashed_guest_pass', '555-5678', 'guest');

-- ====================================================================
-- 3. Property Data (Owned by Alex Johnson - Host)
-- ====================================================================

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
('1f3e7920-5c6a-4d1e-8b0c-9a2f1c8d3b4a', '9d64a852-3d7c-474c-8f1d-230d42129c50', 'Cozy Mountain Cabin', 'A secluded cabin perfect for a winter retreat.', 'Aspen, Colorado', 150.00),
('8c4f2b1a-0a7e-4f3c-9d5b-1e6a7c4f9d2b', '9d64a852-3d7c-474c-8f1d-230d42129c50', 'Spacious Downtown Loft', 'Modern loft in the heart of the city.', 'Seattle, Washington', 220.50);

-- ====================================================================
-- 4. Booking Data (Made by Maria Garcia - Guest)
-- ====================================================================

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
-- Confirmed Booking (Cozy Cabin: 3 nights @ $150 = $450)
('a1b2c3d4-e5f6-7890-1234-567890abcdef', '1f3e7920-5c6a-4d1e-8b0c-9a2f1c8d3b4a', '5a73e160-5a3d-4c91-9e8a-867c4f4b9012', '2025-12-10', '2025-12-13', 450.00, 'confirmed'),
-- Canceled Booking (Downtown Loft: 2 nights @ $220.50 = $441)
('ffeddcba-9876-5432-10fe-dcba98765432', '8c4f2b1a-0a7e-4f3c-9d5b-1e6a7c4f9d2b', '5a73e160-5a3d-4c91-9e8a-867c4f4b9012', '2026-01-05', '2026-01-07', 441.00, 'canceled');

-- ====================================================================
-- 5. Payment Data (For the Confirmed Booking)
-- ====================================================================

INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
('67890abc-def0-1234-5678-90abcdef1234', 'a1b2c3d4-e5f6-7890-1234-567890abcdef', 450.00, 'stripe');

-- ====================================================================
-- 6. Review Data (Maria reviewing Cozy Cabin after the stay)
-- ====================================================================

INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
('0fedcba9-8765-4321-fedc-ba9876543210', '1f3e7920-5c6a-4d1e-8b0c-9a2f1c8d3b4a', '5a73e160-5a3d-4c91-9e8a-867c4f4b9012', 5, 'The cabin was absolutely stunning and very clean. Alex was a fantastic host! Highly recommend.');

-- ====================================================================
-- 7. Message Data (Conversation between Host Alex and Guest Maria)
-- ====================================================================

INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
-- Host Alex asks Maria about her arrival time
('11111111-2222-3333-4444-555555555555', '9d64a852-3d7c-474c-8f1d-230d42129c50', '5a73e160-5a3d-4c91-9e8a-867c4f4b9012', 'Hi Maria, just confirming your check-in time for the Cozy Cabin on December 10th. What time should I expect you?'),
-- Guest Maria replies
('22222222-3333-4444-5555-666666666666', '5a73e160-5a3d-4c91-9e8a-867c4f4b9012', '9d64a852-3d7c-474c-8f1d-230d42129c50', 'Hi Alex, I plan to arrive around 4 PM. Looking forward to the stay!');