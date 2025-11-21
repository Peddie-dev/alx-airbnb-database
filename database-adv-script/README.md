# SQL Join Queries – Airbnb Database

This directory contains SQL scripts demonstrating the use of different types of SQL JOINs for the Airbnb database schema.

## Files

### `joins_queries.sql`
This script includes:
1. **INNER JOIN**  
   Retrieves all bookings along with the users who created them.

2. **LEFT JOIN**  
   Retrieves all properties and their reviews, including properties with *no* reviews.

3. **FULL OUTER JOIN**  
   Retrieves all users and all bookings, even when:
   - A user has no bookings  
   - A booking is not linked to any user  

These queries help demonstrate how to combine data from multiple related tables in different scenarios.

---

## How to Run

Run the SQL script using your database client or psql:

```bash
psql -d airbnb_db -f joins_queries.sql
