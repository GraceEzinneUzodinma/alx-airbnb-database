-- =============================================
-- Advanced SQL Queries: SUBQUERIES
-- =============================================

-- Use the airbnb database
USE airbnb_db;

-- =============================================
-- Query 1: Non-Correlated Subquery
-- Find all properties where the average rating is greater than 4.0
-- =============================================

-- Purpose: Identify high-rated properties for promotional purposes or quality assurance
-- A non-correlated subquery executes once and returns a list of property_ids

SELECT 
    property_id,
    name AS property_name,
    location,
    pricepernight,
    host_id
FROM 
    Property
WHERE 
    property_id IN (
        SELECT 
            property_id
        FROM 
            Review
        GROUP BY 
            property_id
        HAVING 
            AVG(rating) > 4.0
    )
ORDER BY 
    property_id;

-- Expected Output: Properties with average rating > 4.0
-- The subquery calculates average rating per property and returns property_ids
-- The outer query retrieves full property details for those high-rated properties


-- Alternative approach using JOIN (for comparison):
-- This achieves the same result but uses a different technique

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    p.host_id,
    AVG(r.rating) AS average_rating
FROM 
    Property p
INNER JOIN 
    Review r ON p.property_id = r.property_id
GROUP BY 
    p.property_id, p.name, p.location, p.pricepernight, p.host_id
HAVING 
    AVG(r.rating) > 4.0
ORDER BY 
    average_rating DESC;


-- =============================================
-- Query 2: Correlated Subquery
-- Find users who have made more than 3 bookings
-- =============================================

-- Purpose: Identify frequent users for loyalty programs or special offers
-- A correlated subquery executes once for each row in the outer query

SELECT 
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    role
FROM 
    User u
WHERE 
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    user_id;

-- Expected Output: Users who have made more than 3 bookings
-- The subquery counts bookings for each user (correlated by user_id)
-- Only users with booking count > 3 are returned


-- Enhanced version with booking count displayed:

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) AS total_bookings
FROM 
    User u
WHERE 
    (SELECT COUNT(*) 
     FROM Booking b 
     WHERE b.user_id = u.user_id) > 3
ORDER BY 
    total_bookings DESC;

-- This version also shows the actual booking count for each user


-- Alternative approach using JOIN and GROUP BY (for comparison):

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.role,
    COUNT(b.booking_id) AS total_bookings
FROM 
    User u
INNER JOIN 
    Booking b ON u.user_id = b.user_id
GROUP BY 
    u.user_id, u.first_name, u.last_name, u.email, u.phone_number, u.role
HAVING 
    COUNT(b.booking_id) > 3
ORDER BY 
    total_bookings DESC;


-- =============================================
-- Bonus: Additional Subquery Examples
-- =============================================

-- Find properties that have never been booked
SELECT 
    property_id,
    name AS property_name,
    location,
    pricepernight
FROM 
    Property
WHERE 
    property_id NOT IN (
        SELECT DISTINCT property_id 
        FROM Booking
    )
ORDER BY 
    pricepernight DESC;


-- Find the most expensive property in each location
SELECT 
    property_id,
    name AS property_name,
    location,
    pricepernight
FROM 
    Property p1
WHERE 
    pricepernight = (
        SELECT MAX(pricepernight)
        FROM Property p2
        WHERE p2.location = p1.location
    )
ORDER BY 
    location;