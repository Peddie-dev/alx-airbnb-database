# Partitioning Performance Report  
### Airbnb Clone Database – Booking Table Optimization

This report evaluates the performance improvements gained by applying **range partitioning** to the `bookings` table, which had become large and slow to query.

---

# 1. Reason for Partitioning

The `bookings` table grows very quickly in a system like Airbnb.  
Common queries such as:

```sql
SELECT * FROM bookings 
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';
