# Advanced SQL Queries

This directory contains advanced SQL queries for the AirBnB database, including complex joins, subqueries, aggregations, and performance optimizations.

## Files

### joins_queries.sql
Contains SQL queries demonstrating different types of joins:
- **INNER JOIN**: Retrieves bookings with their respective users
- **LEFT JOIN**: Retrieves all properties and their reviews (including properties with no reviews)
- **FULL OUTER JOIN**: Retrieves all users and bookings (including unmatched records)

## Join Types Explained

### INNER JOIN
Returns only rows where there is a match in both tables. Records without matches are excluded.

**Use Case**: When you need data that exists in both tables (e.g., bookings that have associated users).

### LEFT JOIN (LEFT OUTER JOIN)
Returns all rows from the left table and matching rows from the right table. If no match exists, NULL values are returned for right table columns.

**Use Case**: When you need all records from one table regardless of matches (e.g., all properties, even those without reviews).

### FULL OUTER JOIN
Returns all rows from both tables. If no match exists, NULL values are returned for the non-matching side.

**Use Case**: When you need all records from both tables, showing unmatched records from either side (e.g., all users and all bookings, including users without bookings and bookings without users).

## Prerequisites

- MySQL 8.0 or higher (Note: MySQL doesn't support FULL OUTER JOIN natively, so we use UNION of LEFT and RIGHT joins)
- Database schema must be created (run schema.sql from database-script-0x01)
- Sample data should be loaded (run seed.sql from database-script-0x02)

## How to Use

Execute the queries in your MySQL client:
```sql
source joins_queries.sql;
```

Or run individual queries as needed.

## Database Tables Used

- **User**: User accounts (guests, hosts, admins)
- **Booking**: Property reservations
- **Property**: Property listings
- **Review**: Property reviews and ratings

## Query Results

Each query includes comments explaining:
- The purpose of the query
- Which join type is used
- What data is being retrieved
- Expected output columns