-- 1. ENUM Type Definitions

-- Role for User
CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');

-- Status for Booking
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');

-- Payment Method for Payment
CREATE TYPE payment_method_type AS ENUM ('credit_card', 'paypal', 'stripe');


-- 2. CREATE TABLE Statements

-- Table: User
-- Stores user account details and role.
CREATE TABLE "User" (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(50) NULL,
    role user_role NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Table: Property
-- Stores details about rental properties.
CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key Constraint
    CONSTRAINT fk_host
        FOREIGN KEY (host_id)
        REFERENCES "User"(user_id)
        ON DELETE CASCADE -- If a host user is deleted, their properties are also deleted
);

-- Table: Booking
-- Stores reservation details for properties.
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key Constraints
    CONSTRAINT fk_property
        FOREIGN KEY (property_id)
        REFERENCES Property(property_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_guest_user
        FOREIGN KEY (user_id)
        REFERENCES "User"(user_id)
        ON DELETE RESTRICT, -- Do not delete user if they have active bookings

    -- Business Logic Constraint: End date must be after start date
    CHECK (end_date > start_date)
);

-- Table: Payment
-- Stores transaction records associated with bookings.
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID UNIQUE NOT NULL, -- 1:1 relationship with Booking
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method_type NOT NULL,

    -- Foreign Key Constraint
    CONSTRAINT fk_booking_payment
        FOREIGN KEY (booking_id)
        REFERENCES Booking(booking_id)
        ON DELETE RESTRICT -- Do not delete a booking if it has a payment record
);

-- Table: Review
-- Stores user ratings and comments on properties.
CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key Constraints
    CONSTRAINT fk_reviewed_property
        FOREIGN KEY (property_id)
        REFERENCES Property(property_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_reviewer_user
        FOREIGN KEY (user_id)
        REFERENCES "User"(user_id)
        ON DELETE CASCADE,

    -- Value Constraint: Rating must be between 1 and 5
    CHECK (rating >= 1 AND rating <= 5)
);

-- Table: Message
-- Stores direct messages between users.
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- Foreign Key Constraints
    CONSTRAINT fk_sender
        FOREIGN KEY (sender_id)
        REFERENCES "User"(user_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_recipient
        FOREIGN KEY (recipient_id)
        REFERENCES "User"(user_id)
        ON DELETE RESTRICT,

    -- Constraint: A user cannot message themselves (optional business rule)
    CHECK (sender_id <> recipient_id)
);


-- 3. INDEXES for Performance

-- Indexes on Foreign Keys (essential for joins and lookups)
CREATE INDEX idx_property_host_id ON Property (host_id);
CREATE INDEX idx_booking_property_id ON Booking (property_id);
CREATE INDEX idx_booking_user_id ON Booking (user_id);
CREATE INDEX idx_payment_booking_id ON Payment (booking_id);
CREATE INDEX idx_review_property_id ON Review (property_id);
CREATE INDEX idx_review_user_id ON Review (user_id);
CREATE INDEX idx_message_sender_id ON Message (sender_id);
CREATE INDEX idx_message_recipient_id ON Message (recipient_id);

-- Other helpful indexes
CREATE INDEX idx_booking_dates ON Booking (start_date, end_date);
CREATE INDEX idx_property_location ON Property (location);
