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


# SQL Subqueries – Airbnb Database

This directory contains SQL scripts demonstrating the use of correlated and non-correlated subqueries for the Airbnb database schema.

## Files

### `subqueries.sql`
This script includes:

#### 1. Non-Correlated Subquery  
Query that retrieves all properties with an **average review rating greater than 4.0**.  
The subquery runs independently and calculates the average rating per property.

#### 2. Correlated Subquery  
Query that identifies **users who have made more than 3 bookings**.  
The subquery depends on each row from the outer query (per-user evaluation).

---

## How to Run

Execute the SQL script using your database tool or psql command:

```bash
psql -d airbnb_db -f subqueries.sql

# SQL Aggregations & Window Functions – Airbnb Database

This directory contains SQL scripts demonstrating aggregation functions and window functions used for data analysis in the Airbnb database.

## Files

### `aggregations_and_window_functions.sql`

This script includes:

#### 1. Aggregation with GROUP BY  
A query that calculates the **total number of bookings per user** using:
- `COUNT()`
- `GROUP BY`
- `ORDER BY`

#### 2. Window Function (RANK)  
A query that ranks properties based on the **total number of bookings** they have received, using:
- `RANK() OVER()`
- `ORDER BY`
- `GROUP BY`

This helps analyze the most popular properties on the platform.

---

## How to Run

Use psql to execute:

```bash
psql -d airbnb_db -f aggregations_and_window_functions.sql
