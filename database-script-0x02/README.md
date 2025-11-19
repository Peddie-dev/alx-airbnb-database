# Database Seeding Script (`seed.sql`)

This script contains `INSERT` statements to populate the database schema with sample data. It is designed to demonstrate relationships and data flow within the application (e.g., Host owns Property, Guest books Property, Booking is paid for).

---

## Data Population Strategy

The sample data uses realistic scenarios to test data integrity and foreign key constraints:

| Entity | Count | Key Scenarios |
| :--- | :--- | :--- |
| **User** | 3 | An **`admin`**, a **`host`** (Alex Johnson), and a **`guest`** (Maria Garcia). |
| **Property** | 2 | Both properties are owned by the Host (Alex Johnson). |
| **Booking** | 2 | One **`confirmed`** booking (Cozy Cabin) and one **`canceled`** booking (Downtown Loft) by the Guest. |
| **Payment** | 1 | A payment record linked **only** to the **`confirmed`** booking. |
| **Review** | 1 | A 5-star review left by the Guest for the Property they stayed at. |
| **Message** | 2 | A simple conversation exchange between the Host and the Guest. |

---

## Execution Requirement

This script **must** be executed against the database **after** the `schema.sql` script has successfully run, as it relies on the existence of the tables and the custom `ENUM` types (`user_role`, `booking_status`, `payment_method_type`).
