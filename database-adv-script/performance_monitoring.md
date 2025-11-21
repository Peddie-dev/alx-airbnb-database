# Database Performance Monitoring Report  
### Airbnb Clone Database – Continuous Optimization

This document details the process of monitoring, analyzing, and optimizing database performance for frequently used queries in the Airbnb backend.

---

## 1. Objective

- Monitor performance of critical queries  
- Identify bottlenecks and inefficient patterns  
- Apply schema adjustments or indexing improvements  
- Measure performance improvements after changes  

---

## 2. Monitoring Tools Used

- **PostgreSQL EXPLAIN / EXPLAIN ANALYZE**  
  Used to examine query execution plans and identify costly operations.

- **Query Profiling**  
  Execution time, row estimates, sequential scans, index usage.

---

## 3. Queries Monitored

### Query 1: Fetch bookings by user
```sql
SELECT * FROM bookings
WHERE user_id = 5
ORDER BY start_date DESC;
