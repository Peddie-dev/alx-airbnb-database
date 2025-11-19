# Database Schema Script (`schema.sql`)

This script defines the relational schema for the Airbnb platform, creating six core tables and ensuring data integrity through constraints and performance via indexing.

---

## Key Features

* **Platform:** Designed for a **PostgreSQL-compatible** environment.
* **Data Types:** Utilizes `UUID` for all primary keys and Foreign Keys, and custom **`ENUM`** types for role, status, and payment methods.
* **Constraints:** Implements Primary Keys, Foreign Keys (`ON DELETE CASCADE` or `ON DELETE RESTRICT`), **`UNIQUE`** constraints (for `User.email` and `Payment.booking_id`), and **`CHECK`** constraints (for `Review.rating` and `Booking` dates).
* **Indexing:** Creates explicit B-tree indexes on all Foreign Key columns to optimize query performance for common join operations.

---

## Schema Overview

| Table | Primary Key | Foreign Keys | Key Constraints / Indexes |
| :--- | :--- | :--- | :--- |
| **User** | `user_id` | N/A | `email` (UNIQUE) |
| **Property** | `property_id` | `host_id` (User) | Index on `host_id` |
| **Booking** | `booking_id` | `property_id` (Property), `user_id` (User) | Indexes on both FKs, `CHECK (end_date > start_date)` |
| **Payment** | `payment_id` | `booking_id` (Booking) | `booking_id` (UNIQUE), Index on `booking_id` |
| **Review** | `review_id` | `property_id` (Property), `user_id` (User) | Index on both FKs, `CHECK (rating 1-5)` |
| **Message** | `message_id` | `sender_id` (User), `recipient_id` (User) | Indexes on both FKs, `CHECK (sender_id <> recipient_id)` |

---

## Execution Notes

Before running the `schema.sql` script, ensure your database system supports `UUID nd the creation of custom TYPEs (ENUMs). If using an older or different SQL dialect (e.g., MySQL), you may need to adjust UUID to CHAR(36) and replace custom TYPEs with VARCHAR columns and explicit CHECK constraints.
