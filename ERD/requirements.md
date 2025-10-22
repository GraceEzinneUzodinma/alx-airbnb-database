# Entity-Relationship Diagram Requirements

## Entities and Attributes

### User
- user_id (Primary Key, UUID, Indexed)
- first_name (VARCHAR, NOT NULL)
- last_name (VARCHAR, NOT NULL)
- email (VARCHAR, UNIQUE, NOT NULL, Indexed)
- password_hash (VARCHAR, NOT NULL)
- phone_number (VARCHAR, NULL)
- role (ENUM: guest, host, admin, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Property
- property_id (Primary Key, UUID, Indexed)
- host_id (Foreign Key → User.user_id, Indexed)
- name (VARCHAR, NOT NULL)
- description (TEXT, NOT NULL)
- location (VARCHAR, NOT NULL)
- pricepernight (DECIMAL, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- updated_at (TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP)

### Booking
- booking_id (Primary Key, UUID, Indexed)
- property_id (Foreign Key → Property.property_id, Indexed)
- user_id (Foreign Key → User.user_id, Indexed)
- start_date (DATE, NOT NULL)
- end_date (DATE, NOT NULL)
- total_price (DECIMAL, NOT NULL)
- status (ENUM: pending, confirmed, canceled, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Payment
- payment_id (Primary Key, UUID, Indexed)
- booking_id (Foreign Key → Booking.booking_id, Indexed)
- amount (DECIMAL, NOT NULL)
- payment_date (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)
- payment_method (ENUM: credit_card, paypal, stripe, NOT NULL)

### Review
- review_id (Primary Key, UUID, Indexed)
- property_id (Foreign Key → Property.property_id, Indexed)
- user_id (Foreign Key → User.user_id, Indexed)
- rating (INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL)
- comment (TEXT, NOT NULL)
- created_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

### Message
- message_id (Primary Key, UUID, Indexed)
- sender_id (Foreign Key → User.user_id, Indexed)
- recipient_id (Foreign Key → User.user_id, Indexed)
- message_body (TEXT, NOT NULL)
- sent_at (TIMESTAMP, DEFAULT CURRENT_TIMESTAMP)

## Relationships

### User ↔ Property
- One-to-Many: A User (host) can own multiple Properties
- A Property belongs to one User (host)

### User ↔ Booking
- One-to-Many: A User (guest) can make multiple Bookings
- A Booking belongs to one User (guest)

### Property ↔ Booking
- One-to-Many: A Property can have multiple Bookings
- A Booking is associated with one Property

### Booking ↔ Payment
- One-to-One: Each Booking has one Payment
- A Payment is linked to one Booking

### Property ↔ Review
- One-to-Many: A Property can have multiple Reviews
- A Review is associated with one Property

### User ↔ Review
- One-to-Many: A User can write multiple Reviews
- A Review is written by one User

### User ↔ Message (Sender)
- One-to-Many: A User can send multiple Messages
- A Message has one sender

### User ↔ Message (Recipient)
- One-to-Many: A User can receive multiple Messages
- A Message has one recipient