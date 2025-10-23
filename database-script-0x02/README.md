# Database Seed Data

This directory contains SQL scripts to populate the AirBnB database with sample data for testing and development purposes.

## Files

- **seed.sql**: Contains INSERT statements for all tables with realistic sample data

## Sample Data Overview

The seed data includes:
- **5 Users**: Mix of guests, hosts, and admins
- **4 Properties**: Various properties with different locations and prices
- **6 Bookings**: Multiple bookings across different properties and users
- **6 Payments**: Payment records for each booking
- **8 Reviews**: Reviews from guests for properties they've stayed at
- **5 Messages**: Communication between users

## How to Use

After creating the database schema, run:
```sql
source seed.sql;
```

Or execute the SQL file in your preferred database management tool.

## Prerequisites

- Database schema must be created first (run schema.sql from database-script-0x01)
- MySQL 8.0 or higher

## Note

This is sample data for development and testing purposes only. Do not use in production environments.