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
### subqueries.sql
Contains SQL queries demonstrating subqueries:
- **Non-Correlated Subquery**: Finds properties with average rating > 4.0
- **Correlated Subquery**: Finds users who have made more than 3 bookings
- **Bonus queries**: Additional subquery examples

## Subquery Types Explained

### Non-Correlated Subquery
A subquery that executes independently of the outer query. It runs once and returns results used by the outer query.

**Characteristics**:
- Executes only once
- Can be run independently
- Results are passed to outer query

**Use Case**: When you need to filter based on aggregate data from another table (e.g., properties with average rating > 4.0).

### Correlated Subquery
A subquery that references columns from the outer query. It executes once for each row processed by the outer query.

**Characteristics**:
- Executes multiple times (once per outer query row)
- Cannot run independently
- References outer query columns

**Use Case**: When you need row-by-row comparison (e.g., count bookings for each specific user).

## Performance Considerations

- **Non-correlated subqueries** are generally faster as they execute once
- **Correlated subqueries** can be slower for large datasets as they execute repeatedly
- Consider using JOINs with GROUP BY as an alternative for better performance
- Always test query performance with EXPLAIN to understand execution plans
### aggregations_and_window_functions.sql
Contains SQL queries demonstrating aggregations and window functions:
- **COUNT with GROUP BY**: Total bookings per user
- **ROW_NUMBER**: Unique sequential ranking of properties
- **RANK**: Ranking with tied values and gap handling
- **DENSE_RANK**: Ranking with tied values and no gaps
- **PARTITION BY**: Ranking within groups (bonus example)

## Aggregation Functions

Aggregation functions perform calculations on a set of values and return a single value.

### Common Aggregate Functions:
- **COUNT()**: Counts the number of rows
- **SUM()**: Calculates the total sum
- **AVG()**: Calculates the average value
- **MIN()**: Finds the minimum value
- **MAX()**: Finds the maximum value

### GROUP BY Clause
Groups rows that have the same values in specified columns into summary rows. Always used with aggregate functions.

**Example**: Count bookings per user
```sql
SELECT user_id, COUNT(booking_id) 
FROM Booking 
GROUP BY user_id;
```

## Window Functions

Window functions perform calculations across a set of rows related to the current row, without collapsing the result into a single row (unlike aggregate functions with GROUP BY).

### Key Window Functions:

#### ROW_NUMBER()
Assigns a unique sequential integer to each row within a partition.
- Always returns unique values (1, 2, 3, 4...)
- No ties allowed

#### RANK()
Assigns a rank to each row within a partition, with gaps for tied values.
- Tied values get the same rank
- Next rank skips numbers (1, 2, 2, 4, 5...)

#### DENSE_RANK()
Assigns a rank to each row within a partition, without gaps for tied values.
- Tied values get the same rank
- Next rank is consecutive (1, 2, 2, 3, 4...)

### Window Function Syntax:
```sql
function_name() OVER (
    [PARTITION BY column]
    ORDER BY column [ASC|DESC]
)
```

### PARTITION BY
Divides the result set into partitions. Window function is applied to each partition independently.

**Example**: Rank properties within each location
```sql
RANK() OVER (PARTITION BY location ORDER BY total_bookings DESC)
```

## When to Use Each

### Use Aggregations (GROUP BY) when:
- You need summary statistics
- You want to collapse rows into groups
- You need totals, averages, counts per group

### Use Window Functions when:
- You need to keep all detail rows
- You want rankings or running totals
- You need to compare each row to aggregate values
- You want to partition data and analyze within groups

## Performance Tips
- Window functions can be resource-intensive on large datasets
- Use appropriate indexes on columns in PARTITION BY and ORDER BY
- Consider materialized views for frequently-run window function queries
- Test performance with EXPLAIN ANALYZE
### database_index.sql
Contains SQL commands to create indexes for performance optimization:
- Analysis of high-usage columns
- CREATE INDEX statements for all major tables
- Indexes on foreign keys, search columns, and frequently filtered fields
- Composite indexes for common query patterns

### index_performance.md
Documents performance measurements before and after adding indexes:
- EXPLAIN analysis for representative queries
- Performance metrics comparison
- Rows scanned reduction percentages
- Best practices and trade-offs

## Database Indexing

### What is an Index?
An index is a database structure that improves the speed of data retrieval operations. Think of it like a book index - instead of reading every page to find information, you look up the index to jump directly to the relevant pages.

### When to Create Indexes

Index columns that are frequently used in:
- **WHERE clauses** - Filtering conditions
- **JOIN conditions** - Foreign keys linking tables
- **ORDER BY clauses** - Sorting operations
- **GROUP BY clauses** - Aggregation operations

### Types of Indexes

#### Single-Column Index
Index on one column.
```sql
CREATE INDEX idx_user_email ON User(email);
```

#### Composite Index
Index on multiple columns (order matters).
```sql
CREATE INDEX idx_property_location_price ON Property(location, pricepernight);
```

#### Unique Index
Ensures column values are unique (automatically created for PRIMARY KEY and UNIQUE constraints).
```sql
CREATE UNIQUE INDEX idx_user_email_unique ON User(email);
```

### Index Best Practices

✅ **Do:**
- Index foreign key columns
- Index columns in WHERE and JOIN clauses
- Create composite indexes for frequently combined columns
- Monitor index usage and remove unused indexes
- Use EXPLAIN to verify indexes are being used

❌ **Don't:**
- Over-index (too many indexes slow down writes)
- Index low-cardinality columns (e.g., boolean with only true/false)
- Index columns that are rarely queried
- Forget to update indexes when query patterns change

### Performance Measurement

Use `EXPLAIN` to analyze query execution:
```sql
EXPLAIN SELECT * FROM Booking WHERE user_id = 'some-uuid';
```

Key metrics to watch:
- **type**: ALL (bad - full scan) vs ref/range (good - index used)
- **rows**: Number of rows examined
- **key**: Which index is used (NULL means no index)
- **Extra**: Additional operations (Using filesort, Using temporary, etc.)

### Trade-offs

**Benefits:**
- ⚡ Faster SELECT queries
- 📊 Improved JOIN performance
- 🎯 Efficient filtering and sorting

**Costs:**
- 💾 Additional storage space
- ⏱️ Slower INSERT/UPDATE/DELETE operations
- 🔧 Index maintenance overhead

### Maintenance

Regularly review and optimize indexes:
- Identify slow queries with slow query log
- Analyze index usage with performance schema
- Remove unused indexes
- Rebuild fragmented indexes
- Update statistics for query optimizer