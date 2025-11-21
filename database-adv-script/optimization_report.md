# Optimization Report  
### Airbnb Database – Query Performance Tuning

This document analyzes and optimizes a complex SQL query involving **Bookings**, **Users**, **Properties**, and **Payments**. The goal is to reduce execution time and improve overall database performance.

---

# 1. Initial Unoptimized Query

The original query retrieves:

- booking details  
- user profile information  
- property information  
- payment records  

```sql
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
