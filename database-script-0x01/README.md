# Database Schema (DDL)

This directory contains the SQL Data Definition Language (DDL) scripts for creating the AirBnB database schema.

## Files

- **schema.sql**: Contains all CREATE TABLE statements with proper constraints, indexes, and relationships

## Database Design

The schema includes the following entities:
- User
- Property
- Booking
- Payment
- Review
- Message

## How to Use

To create the database schema, run:
```sql
source schema.sql;
```

Or execute the SQL file in your preferred database management tool (MySQL Workbench, phpMyAdmin, etc.).

## Requirements

- MySQL 8.0 or higher
- Proper database privileges to create tables and indexes