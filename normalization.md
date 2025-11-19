# 📊 Database Normalization Analysis (3NF)

## Objective
To review the existing schema for the Airbnb-like platform and confirm its compliance with the Third Normal Form (3NF).

## Existing Schema Review

The provided schema consists of six main entities: `User`, `Property`, `Booking`, `Payment`, `Review`, and `Message`.

### 1. First Normal Form (1NF) Compliance

**Requirement:** All columns must contain atomic (single-valued) data, and there should be no repeating groups.

**Status: ✅ Compliant.**
* All attributes (e.g., `first_name`, `pricepernight`, `start_date`) are atomic.
* The use of dedicated tables and Primary Keys (`user_id`, `property_id`, etc.) ensures there are no repeating groups of data within a single row.

---

### 2. Second Normal Form (2NF) Compliance

**Requirement:** Must be in 1NF, and all non-key attributes must be fully dependent on the **entire** Primary Key. (This mainly applies to tables with composite keys).

**Status: ✅ Compliant.**
* None of the core tables (`User`, `Property`, `Booking`, `Payment`, `Review`, `Message`) use a composite Primary Key for their main identifier.
* For example, in the `Property` table, `name` is fully dependent on `property_id`, not just a part of a key. In the `Review` table, `rating` is fully dependent on the composite key of (`property_id`, `user_id`, `review_id` if considered), but since `review_id` is a simple PK, the dependency is direct and complete.

---

### 3. Third Normal Form (3NF) Compliance

**Requirement:** Must be in 2NF, and there should be **no transitive dependencies**. A transitive dependency occurs when a non-key attribute is dependent on another non-key attribute.

**Status: ✅ Compliant.**

The existing schema design successfully isolates data into distinct tables, eliminating transitive dependencies:

1.  **User Details:** All attributes in the `User` table (e.g., `first_name`, `email`, `role`) are directly dependent on the PK, `user_id`. There are no non-key dependencies.
2.  **Property Details:** Attributes like `name`, `location`, and `pricepernight` are directly dependent on `property_id`. The host's identity (`host_id`) is correctly referenced as a **Foreign Key**, preventing redundant user data from being stored in the `Property` table.
3.  **Booking Details:** Attributes like `start_date` and `total_price` are directly dependent on `booking_id`. The user and property information is correctly handled via Foreign Keys (`user_id`, `property_id`).
4.  **Payment Details:** Payment details (`amount`, `payment_method`) depend only on the `payment_id` and the associated `booking_id`.

**Conclusion:**

The current database design strictly adheres to the principles of the Third Normal Form (3NF) by ensuring that every non-key attribute is dependent on the key, the whole key, and nothing but the key. **No adjustments are necessary** to achieve 3NF based on the provided attributes.
