# Database Normalization to Third Normal Form (3NF)

## Overview
This document explains the normalization process applied to the AirBnB database schema to ensure it meets Third Normal Form (3NF) requirements. Normalization helps eliminate data redundancy, improve data integrity, and make the database more maintainable.

## Normalization Forms

### First Normal Form (1NF)
**Requirements:**
- Each table cell contains atomic (indivisible) values
- Each column contains values of a single type
- Each column has a unique name
- The order of rows and columns doesn't matter

**Analysis:**
All our entities (User, Property, Booking, Payment, Review, Message) already satisfy 1NF:
- All attributes contain atomic values (no arrays or lists)
- Each column has a single data type
- All columns have unique, meaningful names
- No repeating groups exist

**Conclusion:** ✅ Database is in 1NF

### Second Normal Form (2NF)
**Requirements:**
- Must be in 1NF
- All non-key attributes must be fully functionally dependent on the entire primary key (no partial dependencies)

**Analysis:**
Our schema uses single-column primary keys (UUIDs) for all entities:
- **User**: user_id is the primary key; all other attributes depend on the entire key
- **Property**: property_id is the primary key; all attributes fully depend on it
- **Booking**: booking_id is the primary key; all attributes depend on the entire key
- **Payment**: payment_id is the primary key; all attributes fully depend on it
- **Review**: review_id is the primary key; all attributes fully depend on it
- **Message**: message_id is the primary key; all attributes fully depend on it

Since we don't have composite primary keys, partial dependency is not possible.

**Conclusion:** ✅ Database is in 2NF

### Third Normal Form (3NF)
**Requirements:**
- Must be in 2NF
- No transitive dependencies (non-key attributes must not depend on other non-key attributes)

**Analysis:**

#### User Entity
All attributes (first_name, last_name, email, password_hash, phone_number, role, created_at) depend directly on user_id with no transitive dependencies.
- ✅ No issues found

#### Property Entity
All attributes depend directly on property_id. The host_id is a foreign key, not a transitive dependency.
- ✅ No issues found

#### Booking Entity
Potential issue identified:
- `total_price` could be calculated from `start_date`, `end_date`, and the property's `pricepernight`
- However, storing `total_price` is acceptable because:
  - It captures the price at the time of booking (historical accuracy)
  - Property prices may change over time
  - Avoids complex calculations for reporting
- ✅ Acceptable design decision (denormalization for performance)

#### Payment Entity
All attributes depend directly on payment_id. The booking_id is a foreign key reference.
- ✅ No issues found

#### Review Entity
All attributes depend directly on review_id.
- ✅ No issues found

#### Message Entity
All attributes depend directly on message_id. Both sender_id and recipient_id are foreign keys.
- ✅ No issues found

## Normalization Adjustments

### Original Schema Assessment
After reviewing the schema against 3NF principles, the database design is already well-normalized:

1. **No Repeating Groups**: All entities have atomic values
2. **No Partial Dependencies**: All tables use single-column primary keys
3. **No Transitive Dependencies**: All non-key attributes depend directly on primary keys

### Design Decisions

#### Calculated Fields (Denormalization)
We intentionally keep `total_price` in the Booking entity as a denormalized field because:
- It preserves historical pricing information
- It improves query performance for financial reports
- It eliminates the need to recalculate prices when property rates change
- This is an acceptable trade-off between normalization and practical requirements

#### Foreign Keys
All foreign keys properly reference primary keys in related tables:
- Property.host_id → User.user_id
- Booking.property_id → Property.property_id
- Booking.user_id → User.user_id
- Payment.booking_id → Booking.booking_id
- Review.property_id → Property.property_id
- Review.user_id → User.user_id
- Message.sender_id → User.user_id
- Message.recipient_id → User.user_id

## Conclusion

The AirBnB database schema successfully achieves Third Normal Form (3NF):
- ✅ All tables are in 1NF (atomic values, no repeating groups)
- ✅ All tables are in 2NF (no partial dependencies)
- ✅ All tables are in 3NF (no transitive dependencies)

The schema is well-designed with minimal redundancy, proper referential integrity through foreign keys, and strategic denormalization where it provides clear benefits for performance and data accuracy.