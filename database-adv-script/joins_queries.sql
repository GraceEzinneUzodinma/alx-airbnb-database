-- =============================================
-- Advanced SQL Queries: JOINS
-- =============================================

-- Use the airbnb database
USE airbnb_db;

-- =============================================
-- Query 1: INNER JOIN
-- Retrieve all bookings and the respective users who made those bookings
-- =============================================

-- Purpose: Get booking details along with user information for all confirmed bookings
-- This query only returns bookings that have an associated user (matching records only)

SELECT 
    Booking.booking_id,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status,
    User.user_id,
    User.first_name,
    User.last_name,
    User.email,
    User.phone_number
FROM 
    Booking
INNER JOIN 
    User ON Booking.user_id = User.user_id
ORDER BY 
    Booking.created_at DESC;

-- Expected Output: All bookings with complete user information
-- Bookings without a user_id or users without bookings will NOT appear


-- =============================================
-- Query 2: LEFT JOIN
-- Retrieve all properties and their reviews, including properties that have no reviews
-- =============================================

-- Purpose: Get a complete list of all properties with their reviews
-- Properties without reviews will still appear with NULL values in review columns

SELECT 
    Property.property_id,
    Property.name AS property_name,
    Property.location,
    Property.pricepernight,
    Review.review_id,
    Review.rating,
    Review.comment,
    Review.created_at AS review_date,
    User.first_name AS reviewer_first_name,
    User.last_name AS reviewer_last_name
FROM 
    Property
LEFT JOIN 
    Review ON Property.property_id = Review.property_id
LEFT JOIN 
    User ON Review.user_id = User.user_id
ORDER BY 
    Property.property_id, Review.created_at DESC;

-- Expected Output: All properties listed, with review details where available
-- Properties without reviews will show NULL for review columns
-- This helps identify which properties need more guest feedback


-- =============================================
-- Query 3: FULL OUTER JOIN
-- Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- =============================================

-- Purpose: Get a complete picture of all users and all bookings
-- Shows users who haven't made bookings and bookings not linked to users (orphaned records)

-- Note: MySQL does not support FULL OUTER JOIN directly
-- We simulate it using a UNION of LEFT JOIN and RIGHT JOIN

SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    User.email,
    User.role,
    Booking.booking_id,
    Booking.property_id,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status
FROM 
    User
LEFT JOIN 
    Booking ON User.user_id = Booking.user_id

UNION

SELECT 
    User.user_id,
    User.first_name,
    User.last_name,
    User.email,
    User.role,
    Booking.booking_id,
    Booking.property_id,
    Booking.start_date,
    Booking.end_date,
    Booking.total_price,
    Booking.status
FROM 
    User
RIGHT JOIN 
    Booking ON User.user_id = Booking.user_id
ORDER BY 
    user_id, booking_id;

-- Expected Output: 
-- - All users (even those without bookings) - user info present, booking columns NULL
-- - All bookings (even orphaned ones without valid user) - booking info present, user columns NULL
-- - Users with bookings - both user and booking info present
-- This query is useful for data quality checks and identifying orphaned records