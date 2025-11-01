-- =============================================
-- Database Indexing for Performance Optimization
-- =============================================

-- Use the airbnb database
USE airbnb_db;

-- =============================================
-- PART 1: Identify High-Usage Columns
-- =============================================

-- High-usage columns are those frequently used in:
-- 1. WHERE clauses (filtering)
-- 2. JOIN conditions (relationships)
-- 3. ORDER BY clauses (sorting)
-- 4. GROUP BY clauses (aggregation)

-- Analysis of High-Usage Columns:

-- USER TABLE:
-- - user_id: Primary key (already indexed), used in JOINs
-- - email: Used in WHERE for login/authentication, UNIQUE constraint (already indexed)
-- - role: Used in WHERE for filtering by user type

-- BOOKING TABLE:
-- - booking_id: Primary key (already indexed)
-- - property_id: Foreign key, used in JOINs and WHERE clauses
-- - user_id: Foreign key, used in JOINs and WHERE clauses
-- - start_date, end_date: Used in WHERE for date range queries
-- - status: Used in WHERE for filtering bookings

-- PROPERTY TABLE:
-- - property_id: Primary key (already indexed)
-- - host_id: Foreign key, used in JOINs and WHERE clauses
-- - location: Used in WHERE for location searches
-- - pricepernight: Used in WHERE and ORDER BY for price filtering/sorting


-- =============================================
-- PART 2: Create Indexes
-- =============================================

-- Note: Primary keys and UNIQUE constraints automatically create indexes
-- We focus on columns that need additional indexing for performance

-- -----------------------------------------------
-- Indexes for USER Table
-- -----------------------------------------------

-- Index on email (if not already created by UNIQUE constraint)
-- Used for: Login queries, user lookups
CREATE INDEX idx_user_email ON User(email);

-- Index on role for filtering users by type
-- Used for: Admin queries filtering by guest/host/admin
CREATE INDEX idx_user_role ON User(role);


-- -----------------------------------------------
-- Indexes for BOOKING Table
-- -----------------------------------------------

-- Index on property_id for JOIN operations
-- Used for: Queries joining Booking with Property
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index on user_id for JOIN operations
-- Used for: Queries joining Booking with User
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index on status for filtering bookings
-- Used for: Queries filtering by pending/confirmed/canceled
CREATE INDEX idx_booking_status ON Booking(status);

-- Composite index on start_date and end_date
-- Used for: Date range queries (availability checks)
CREATE INDEX idx_booking_dates ON Booking(start_date, end_date);

-- Composite index for common query pattern
-- Used for: Finding user's bookings with specific status
CREATE INDEX idx_booking_user_status ON Booking(user_id, status);


-- -----------------------------------------------
-- Indexes for PROPERTY Table
-- -----------------------------------------------

-- Index on host_id for JOIN operations
-- Used for: Queries finding properties by host
CREATE INDEX idx_property_host_id ON Property(host_id);

-- Index on location for search queries
-- Used for: Location-based property searches
CREATE INDEX idx_property_location ON Property(location);

-- Index on pricepernight for filtering and sorting
-- Used for: Price range queries and sorting by price
CREATE INDEX idx_property_price ON Property(pricepernight);

-- Composite index for location and price searches
-- Used for: Common search pattern (properties in location within price range)
CREATE INDEX idx_property_location_price ON Property(location, pricepernight);


-- -----------------------------------------------
-- Indexes for REVIEW Table
-- -----------------------------------------------

-- Index on property_id for JOIN operations
-- Used for: Getting reviews for a property
CREATE INDEX idx_review_property_id ON Review(property_id);

-- Index on user_id for JOIN operations
-- Used for: Getting reviews by a user
CREATE INDEX idx_review_user_id ON Review(user_id);

-- Index on rating for filtering high/low rated reviews
-- Used for: Queries filtering by rating threshold
CREATE INDEX idx_review_rating ON Review(rating);


-- -----------------------------------------------
-- Indexes for PAYMENT Table
-- -----------------------------------------------

-- Index on booking_id for JOIN operations
-- Used for: Linking payments to bookings
CREATE INDEX idx_payment_booking_id ON Payment(booking_id);

-- Index on payment_date for date-based queries
-- Used for: Financial reports by date range
CREATE INDEX idx_payment_date ON Payment(payment_date);


-- -----------------------------------------------
-- Indexes for MESSAGE Table
-- -----------------------------------------------

-- Index on sender_id for finding sent messages
CREATE INDEX idx_message_sender_id ON Message(sender_id);

-- Index on recipient_id for finding received messages
CREATE INDEX idx_message_recipient_id ON Message(recipient_id);

-- Composite index for conversation queries
-- Used for: Finding messages between two users
CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id);


-- =============================================
-- PART 3: View Created Indexes
-- =============================================

-- Show all indexes on User table
SHOW INDEX FROM User;

-- Show all indexes on Booking table
SHOW INDEX FROM Booking;

-- Show all indexes on Property table
SHOW INDEX FROM Property;

-- Show all indexes on Review table
SHOW INDEX FROM Review;

-- Show all indexes on Payment table
SHOW INDEX FROM Payment;

-- Show all indexes on Message table
SHOW INDEX FROM Message;


-- =============================================
-- PART 4: Drop Indexes (if needed)
-- =============================================

-- Use these commands to remove indexes if they're not improving performance
-- or if you need to recreate them

-- DROP INDEX idx_user_email ON User;
-- DROP INDEX idx_user_role ON User;
-- DROP INDEX idx_booking_property_id ON Booking;
-- DROP INDEX idx_booking_user_id ON Booking;
-- DROP INDEX idx_booking_status ON Booking;
-- DROP INDEX idx_booking_dates ON Booking;
-- DROP INDEX idx_booking_user_status ON Booking;
-- DROP INDEX idx_property_host_id ON Property;
-- DROP INDEX idx_property_location ON Property;
-- DROP INDEX idx_property_price ON Property;
-- DROP INDEX idx_property_location_price ON Property;
-- DROP INDEX idx_review_property_id ON Review;
-- DROP INDEX idx_review_user_id ON Review;
-- DROP INDEX idx_review_rating ON Review;
-- DROP INDEX idx_payment_booking_id ON Payment;
-- DROP INDEX idx_payment_date ON Payment;
-- DROP INDEX idx_message_sender_id ON Message;
-- DROP INDEX idx_message_recipient_id ON Message;
-- DROP INDEX idx_message_conversation ON Message;


-- =============================================
-- Notes on Index Best Practices
-- =============================================

-- 1. Don't over-index: Too many indexes slow down INSERT/UPDATE/DELETE operations
-- 2. Index columns used in WHERE, JOIN, and ORDER BY clauses
-- 3. Consider composite indexes for queries using multiple columns together
-- 4. Monitor index usage with performance monitoring tools
-- 5. Regularly analyze and optimize indexes based on actual query patterns
-- 6. Primary keys and UNIQUE constraints automatically create indexes
-- 7. Foreign keys should generally be indexed
-- 8. Consider the size of the data when creating indexes
-- 9. Test performance before and after adding indexes
-- 10. Remove unused indexes to improve write performance