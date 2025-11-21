# Index Performance Analysis  
### Airbnb Clone Database Optimization

This document analyzes performance improvements achieved by adding indexes to frequently queried columns in the **Users**, **Bookings**, **Properties**, **Reviews**, and **Payments** tables.

---

# 1. Identified High-Usage Columns

Based on typical Airbnb system operations, the following columns are frequently accessed:

## **Users Table**
- `email` — used during login  
- `id` — used in JOIN operations  
- `name` — sometimes used for ordering  

## **Bookings Table**
- `user_id` — used in filtering bookings by user  
- `property_id` — used in joins and filtering  
- `check_in_date` — used for validation & sorting  

## **Properties Table**
- `city` — used in search filters  
- `price` — used for filtering & sorting  
- `id` — used for joins  

## **Reviews Table**
- `property_id`  
- `user_id`  

## **Payments Table**
- `user_id`  
- `booking_id`  

All columns above are prime candidates for indexing.

---

# 2. Index Creation

Indexes are defined in the `database_index.sql` file and include:

- Email index for fast authentication  
- User ID and Property ID indexes for faster JOIN operations  
- City and price indexes for Property filtering  
- Booking date index for availability checks  
- Review and Payment mapping indexes  

---

# 3. Performance Tests  
Performance was measured using `EXPLAIN` and `EXPLAIN ANALYZE`. Below are representative results.

---

# 4. Performance Measurements

## **Test 1: Retrieve all bookings for a user**

### Query:
```sql
SELECT * FROM bookings WHERE user_id = 5;
