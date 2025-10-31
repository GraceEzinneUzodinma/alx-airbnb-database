-- =============================================
-- Advanced SQL Queries: AGGREGATIONS AND WINDOW FUNCTIONS
-- =============================================

-- Use the airbnb database
USE airbnb_db;

-- =============================================
-- Query 1: Aggregation with COUNT and GROUP BY
-- Find the total number of bookings made by each user
-- =============================================

-- Purpose: Analyze user booking behavior to identify frequent users
-- Uses COUNT aggregate function with GROUP BY to count bookings per user

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email
ORDER BY 
    total_bookings DESC, u.last_name ASC;

-- Expected Output: Each user with their total booking count
-- Users with no bookings will show 0 (due to LEFT JOIN)
-- Results ordered by booking count (highest first), then by last name


-- Enhanced version with additional statistics:

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    COUNT(b.booking_id) AS total_bookings,
    COALESCE(SUM(b.total_price), 0) AS total_spent,
    COALESCE(AVG(b.total_price), 0) AS average_booking_value,
    MIN(b.created_at) AS first_booking_date,
    MAX(b.created_at) AS last_booking_date
FROM 
    User u
LEFT JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email, u.role
HAVING 
    COUNT(b.booking_id) > 0
ORDER BY 
    total_bookings DESC;

-- This version includes:
-- - Total amount spent
-- - Average booking value
-- - First and last booking dates
-- - Only shows users who have made at least one booking


-- =============================================
-- Query 2: Window Functions - ROW_NUMBER
-- Rank properties based on the total number of bookings using ROW_NUMBER
-- =============================================

-- Purpose: Rank properties by popularity (number of bookings)
-- ROW_NUMBER assigns a unique sequential number to each property

SELECT 
    property_id,
    property_name,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_number_rank
FROM (
    SELECT 
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Property p
    LEFT JOIN 
        Booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id, p.name
) AS property_booking_counts
ORDER BY 
    row_number_rank;

-- Expected Output: Properties ranked by booking count
-- ROW_NUMBER gives unique ranks (1, 2, 3, 4, ...)
-- Even properties with the same booking count get different ranks


-- =============================================
-- Query 3: Window Functions - RANK
-- Rank properties based on the total number of bookings using RANK
-- =============================================

-- Purpose: Rank properties by popularity with tied ranks
-- RANK assigns the same rank to properties with equal booking counts

SELECT 
    property_id,
    property_name,
    location,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank_position
FROM (
    SELECT 
        p.property_id,
        p.name AS property_name,
        p.location,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Property p
    LEFT JOIN 
        Booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id, p.name, p.location
) AS property_booking_counts
ORDER BY 
    rank_position, property_name;

-- Expected Output: Properties ranked by booking count
-- RANK gives same rank for tied values (e.g., 1, 2, 2, 4...)
-- Properties with equal bookings share the same rank
-- Next rank skips numbers (if two properties are rank 2, next is rank 4)


-- =============================================
-- Query 4: Comparison - ROW_NUMBER vs RANK vs DENSE_RANK
-- Shows the difference between window functions
-- =============================================

SELECT 
    property_id,
    property_name,
    location,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_num,
    RANK() OVER (ORDER BY total_bookings DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY total_bookings DESC) AS dense_rank_num
FROM (
    SELECT 
        p.property_id,
        p.name AS property_name,
        p.location,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Property p
    LEFT JOIN 
        Booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id, p.name, p.location
) AS property_booking_counts
ORDER BY 
    total_bookings DESC, property_name;

-- Comparison:
-- ROW_NUMBER: Always unique (1, 2, 3, 4, 5...)
-- RANK: Same rank for ties, skips numbers (1, 2, 2, 4, 5...)
-- DENSE_RANK: Same rank for ties, no gaps (1, 2, 2, 3, 4...)


-- =============================================
-- Bonus: Advanced Window Function Example
-- Partition ranking by location
-- =============================================

-- Rank properties within each location

SELECT 
    property_id,
    property_name,
    location,
    total_bookings,
    RANK() OVER (PARTITION BY location ORDER BY total_bookings DESC) AS rank_in_location,
    RANK() OVER (ORDER BY total_bookings DESC) AS overall_rank
FROM (
    SELECT 
        p.property_id,
        p.name AS property_name,
        p.location,
        COUNT(b.booking_id) AS total_bookings
    FROM 
        Property p
    LEFT JOIN 
        Booking b ON p.property_id = b.property_id
    GROUP BY 
        p.property_id, p.name, p.location
) AS property_booking_counts
ORDER BY 
    location, rank_in_location;

-- This shows:
-- - Rank of each property within its location
-- - Overall rank across all properties
-- Useful for identifying top properties in each city/area