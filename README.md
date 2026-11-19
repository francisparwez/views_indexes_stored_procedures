# SQL Server: Views, Indexes & Stored Procedures

A practical Microsoft SQL Server (T-SQL) learning project containing **60 beginner-to-intermediate exercises** built around a shared e-commerce database. The database setup script creates the schema, inserts sample records and runs verification queries. The first three Beginner View exercises are implemented in `01_Views/01_Beginner.sql`; the remaining exercise descriptions define the practice curriculum and are to be implemented.

## Project Overview

This project focuses on three important SQL Server topics:

| Module            | Exercises | Difficulty                        |
| ----------------- | --------: | --------------------------------- |
| Views             |        20 | 10 Beginner + 10 Intermediate     |
| Indexes           |        20 | 10 Beginner + 10 Intermediate     |
| Stored Procedures |        20 | 10 Beginner + 10 Intermediate     |
| **Total**         |    **60** | **30 Beginner + 30 Intermediate** |

Each exercise is based on a business scenario and is documented in the accompanying practice material with a problem statement, task, hint, T-SQL implementation and explanation. Completed exercise scripts are saved in their respective module folders. Currently, Views Q1, Q2 and Q3 are implemented; the remaining exercises are pending.

## Database Context

All exercises use the `EcommerceDB` database.

### Tables

| Table      | Important Columns                                               | Purpose                         |
| ---------- | --------------------------------------------------------------- | ------------------------------- |
| `Users`    | UserID, FirstName, LastName, Email, City, RegistrationDate      | Customer information            |
| `Products` | ProductID, ProductName, Category, Price, StockQuantity          | Product catalogue and inventory |
| `Orders`   | OrderID, UserID, ProductID, OrderDate, TotalAmount, OrderStatus | Customer orders                 |

### Relationships

- `Users.UserID` → `Orders.UserID`
- `Products.ProductID` → `Orders.ProductID`

### Schema Implementation

The setup script implements the three tables with the following database features:

- `IDENTITY(1,1)` primary keys on `Users`, `Products` and `Orders`.
- Clustered primary-key constraints on all three tables.
- A UNIQUE constraint on `Users.Email`.
- Foreign keys from `Orders.UserID` to `Users.UserID` and `Orders.ProductID` to `Products.ProductID`.
- CHECK constraints for positive product prices and order amounts, nonnegative stock quantities, and valid order statuses.
- A default constraint on `Users.RegistrationDate`, using the current SQL Server date when a value is omitted.

The script also includes verification queries for table row counts, customer order counts (using LEFT JOIN), UserID 1 and ProductID 3.

### Sample Data

The setup script creates and populates the database with:

| Table     | Sample Records |
| --------- | -------------: |
| Users     |             35 |
| Products  |             35 |
| Orders    |             70 |
| **Total** |        **140** |

The sample data covers multiple cities and product categories, four order statuses (`Pending`, `Shipped`, `Completed` and `Cancelled`), varied order amounts, and repeat customers. Orders are assigned to the first 25 users, leaving 10 users without orders for LEFT JOIN exercises. The 70 orders reference five of the 35 products, so the remaining products have no matching order records. Order dates range from 2025-01-01 to 2025-03-14.

## Project Structure

```text
views_indexes_stored_procedures/
├── 00_Database_Setup/
│   └── ecommerce_database.sql
├── 01_Views/
│   └── 01_Beginner.sql
└── README.md
```

## Database Setup

1. Open SQL Server Management Studio (SSMS).
2. Open `00_Database_Setup/ecommerce_database.sql`.
3. Execute the complete script.
4. Confirm that the verification query returns 35 Users, 35 Products and 70 Orders.
5. Review the final LEFT JOIN query to confirm that users without orders are included.
6. Select `EcommerceDB` before running individual practice scripts.

> **Note:** The script creates `EcommerceDB` only if it does not already exist, but drops and recreates `dbo.Orders`, `dbo.Products` and `dbo.Users` whenever the script is rerun. Existing records and table-level changes will be deleted. Run it only in this practice database.

## Module 1 – Views

**20 Questions · 10 Beginner + 10 Intermediate**

The questions below describe the View exercises. Q1, Q2 and Q3 are implemented in `01_Views/01_Beginner.sql`; the database setup script itself does not create Views.

**Completed implementations — Q1–Q3:** The script selects `EcommerceDB`, creates `vw_Users` to expose all columns from `Users`, and verifies it with a SELECT query. It also creates `vw_UserContactDetails` with only `UserID`, `FirstName`, `LastName`, `Email` and `City`, then queries that View. For Q3, it creates `vw_KarachiUsers` using `WHERE City = 'Karachi'` and queries the View to return only Karachi customers. These Views store query definitions rather than separate copies of the table data.

### Learning Objectives

- Create and query Views.
- Select specific columns and filter records.
- Combine tables using INNER JOIN and LEFT JOIN.
- Build aggregate Views using COUNT, SUM and GROUP BY.
- Modify and drop Views.
- Use CASE expressions, HAVING, subqueries and CTEs.
- Apply WITH CHECK OPTION and SCHEMABINDING.
- Use window functions in Views.
- Inspect View definitions, dependencies and execution plans.

### Beginner Exercises (Q1–Q10)

| Question | Objective / Implementation                                                                                                                                                                            |
| -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Q1       | <u>Completed</u> — create `vw_Users` to expose all columns from `Users`; verify it with `SELECT * FROM vw_Users` in `01_Views/01_Beginner.sql`.                                                       |
| Q2       | <u>Completed</u> — create `vw_UserContactDetails` exposing `UserID`, `FirstName`, `LastName`, `Email` and `City`; verify it with `SELECT * FROM vw_UserContactDetails` in `01_Views/01_Beginner.sql`. |
| Q3       | <u>Completed</u> — create `vw_KarachiUsers` with `WHERE City = 'Karachi'` and verify it with `SELECT * FROM vw_KarachiUsers` in `01_Views/01_Beginner.sql`.                                           |
| Q4       | Retrieve recent users and sort the View output by registration date (`vw_RecentUsers`).                                                                                                               |
| Q5       | Join Users and Orders (`vw_UserOrders`).                                                                                                                                                              |
| Q6       | Join Users, Products and Orders (`vw_OrderDetails`).                                                                                                                                                  |
| Q7       | Count orders per customer (`vw_CustomerOrderCount`).                                                                                                                                                  |
| Q8       | Calculate customer order totals (`vw_CustomerRevenue`).                                                                                                                                               |
| Q9       | Modify an existing View using ALTER VIEW.                                                                                                                                                             |
| Q10      | Remove a View using DROP VIEW IF EXISTS.                                                                                                                                                              |

### Intermediate Exercises (Q11–Q20)

| Question | Objective / Implementation                                                                  |
| -------- | ------------------------------------------------------------------------------------------- |
| Q11      | Preserve customers without orders using LEFT JOIN (`vw_AllCustomerOrders`).                 |
| Q12      | Categorise orders with CASE (`vw_OrderValueCategory`).                                      |
| Q13      | Filter grouped customers using HAVING (`vw_FrequentCustomers`).                             |
| Q14      | Identify above-average-priced products using a scalar subquery (`vw_AboveAverageProducts`). |
| Q15      | Calculate completed-order revenue using a CTE (`vw_HighValueCustomers`).                    |
| Q16      | Restrict modifications through a filtered View using WITH CHECK OPTION.                     |
| Q17      | Protect referenced table definitions using SCHEMABINDING.                                   |
| Q18      | Find each customer's highest-value order using MAX and a JOIN.                              |
| Q19      | Rank customer orders using ROW_NUMBER and PARTITION BY.                                     |
| Q20      | Inspect View definitions, dependencies and execution plans.                                 |

## Module 2 – Indexes

**20 Questions · 10 Beginner + 10 Intermediate**

The questions below describe the Index exercises to be implemented. The setup script creates clustered primary-key indexes and the unique constraint on `Users.Email`; it does not create the additional exercise indexes.

### Learning Objectives

- Understand why indexes are used.
- Inspect existing indexes through SQL Server catalog views.
- Create clustered and nonclustered indexes.
- Understand unique and composite indexes.
- Create filtered indexes.
- Use INCLUDE columns to cover queries.
- Understand index key order and the leftmost-prefix principle.
- Inspect fragmentation and index usage.
- Reorganise and rebuild indexes.
- Review execution plans and missing-index recommendations.

### Beginner Exercises (Q1–Q10)

| Question | Objective / Implementation                               |
| -------- | -------------------------------------------------------- |
| Q1       | Inspect existing indexes using `sys.indexes`.            |
| Q2       | Create a nonclustered index on Users.City.               |
| Q3       | Create a nonclustered index on Orders.OrderDate.         |
| Q4       | Create a nonclustered index on Orders.OrderStatus.       |
| Q5       | Understand unique indexes and uniqueness enforcement.    |
| Q6       | Create a composite index on UserID and OrderDate.        |
| Q7       | Create a separate practice table with a clustered index. |
| Q8       | Create a nonclustered index with included columns.       |
| Q9       | Remove an index using DROP INDEX IF EXISTS.              |
| Q10      | Compare query execution plans and index access methods.  |

### Intermediate Exercises (Q11–Q20)

| Question | Objective / Implementation                                          |
| -------- | ------------------------------------------------------------------- |
| Q11      | Create a filtered index for Pending orders.                         |
| Q12      | Create a composite covering index with INCLUDE.                     |
| Q13      | Understand composite index key order and create an OrderDate index. |
| Q14      | Inspect and create an index supporting Orders.UserID joins.         |
| Q15      | Inspect index fragmentation using `sys.dm_db_index_physical_stats`. |
| Q16      | Reorganise an index using ALTER INDEX REORGANIZE.                   |
| Q17      | Rebuild an index using ALTER INDEX REBUILD.                         |
| Q18      | Inspect index usage statistics using `sys.dm_db_index_usage_stats`. |
| Q19      | Create an index with FILLFACTOR = 80.                               |
| Q20      | Review missing-index recommendations using SQL Server DMVs.         |

## Module 3 – Stored Procedures

**20 Questions · 10 Beginner + 10 Intermediate**

The questions below describe the Stored Procedure exercises to be implemented. The supplied database setup script does not create any Stored Procedures.

### Learning Objectives

- Create and execute Stored Procedures.
- Work with input parameters and default values.
- Use multiple parameters and variables.
- Retrieve and aggregate customer and order information.
- Insert, update and delete records through procedures.
- Return values through OUTPUT parameters.
- Apply conditional logic using IF and CASE.
- Modify existing procedures.
- Handle errors using TRY...CATCH.
- Manage transactions using BEGIN TRANSACTION, COMMIT and ROLLBACK.
- Use parameterised dynamic SQL with sp_executesql.
- Implement pagination using OFFSET and FETCH NEXT.
- Combine multiple SQL operations into reporting procedures.

### Beginner Exercises (Q1–Q10)

| Question | Objective / Implementation                            |
| -------- | ----------------------------------------------------- |
| Q1       | Create and execute a procedure retrieving all users.  |
| Q2       | Retrieve a customer using a UserID input parameter.   |
| Q3       | Search customers using City and FirstName parameters. |
| Q4       | Use a default OrderStatus parameter.                  |
| Q5       | Retrieve orders sorted by TotalAmount descending.     |
| Q6       | Join Users and Orders in a procedure.                 |
| Q7       | Calculate total order revenue using SUM.              |
| Q8       | Count orders per customer using GROUP BY.             |
| Q9       | Insert a customer using procedure parameters.         |
| Q10      | Update a customer's City using UserID.                |

### Intermediate Exercises (Q11–Q20)

| Question | Objective / Implementation                                                             |
| -------- | -------------------------------------------------------------------------------------- |
| Q11      | Return the user count through an OUTPUT parameter.                                     |
| Q12      | Calculate completed-order revenue for a selected customer.                             |
| Q13      | Classify customers based on completed-order revenue using CASE and a CTE.              |
| Q14      | Delete a customer only when they have no orders.                                       |
| Q15      | Modify an existing procedure using ALTER PROCEDURE.                                    |
| Q16      | Handle registration errors using TRY...CATCH.                                          |
| Q17      | Place an order and reduce product stock atomically using a transaction.                |
| Q18      | Search products using parameterised dynamic SQL and sp_executesql.                     |
| Q19      | Retrieve paginated order results using OFFSET and FETCH NEXT.                          |
| Q20      | Build a customer business summary using LEFT JOIN, COUNT, SUM, CASE, COALESCE and MAX. |

## SQL Server Concepts Practised

- DDL: CREATE, ALTER, DROP.
- DML: SELECT, INSERT, UPDATE, DELETE.
- Joins: INNER JOIN, LEFT JOIN.
- Aggregations: COUNT, SUM, AVG, MAX.
- Filtering: WHERE, HAVING, CASE.
- Subqueries and CTEs.
- Window functions: ROW_NUMBER, OVER, PARTITION BY.
- Views: WITH CHECK OPTION, SCHEMABINDING.
- Indexes: CLUSTERED, NONCLUSTERED, UNIQUE, INCLUDE, filtered indexes.
- System catalog views and dynamic management views.
- Stored Procedures, parameters and variables.
- Transactions and error handling.
- Dynamic SQL and pagination.

## Important Implementation Notes

- `UserID`, `ProductID` and `OrderID` are IDENTITY primary keys with clustered primary-key constraints. `Users.Email` has a UNIQUE constraint (normally backed by a unique nonclustered index in SQL Server). The unique-index exercise is conceptual; do not create a duplicate unique index on that column.
- The setup script defines clustered primary keys on all three tables: `Users`, `Products` and `Orders`. The clustered-index exercise therefore needs a separate demonstration table.
- The setup script does not create an `Orders.OrderDate` index. Create it only in the relevant Index exercise, then inspect existing indexes before rerunning that exercise to avoid duplicate index names.
- The `Orders.UserID` and `Orders.ProductID` foreign keys do not automatically create indexes on their referencing columns in SQL Server.
- Index recommendations, fragmentation and usage statistics depend on the workload, SQL Server version, permissions and database lifecycle.
- The order-placement transaction should be tested only in a development database.
- The setup data is synthetic and intended for learning, not production use.
- The script adds CHECK constraints for positive product prices and order amounts, nonnegative stock, and the four allowed order statuses. It also defines a default `RegistrationDate` for new users.

## Learning Checklist

- [x] Prepare the EcommerceDB creation and three-table setup script.
- [x] Add INSERT statements for 35 Users, 35 Products and 70 Orders.
- [x] Include record-count and customer-order verification queries.
- [x] Execute the setup script in SSMS and verify 35 Users, 35 Products and 70 Orders.
- [x] Complete Beginner Views Q1: create and query `vw_Users`.
- [x] Complete Beginner Views Q2: create and query `vw_UserContactDetails` with selected customer contact columns.
- [x] Complete Beginner Views Q3: create and query `vw_KarachiUsers` to filter users by city.
- [ ] Complete the remaining 7 Beginner Views exercises (Q4–Q10).
- [ ] Complete 10 Intermediate Views exercises.
- [ ] Complete 10 Beginner Indexes exercises.
- [ ] Complete 10 Intermediate Indexes exercises.
- [ ] Complete 10 Beginner Stored Procedures exercises.
- [ ] Complete 10 Intermediate Stored Procedures exercises.
- [ ] Inspect query execution plans.
- [ ] Upload the remaining completed SQL exercise scripts to GitHub.
- [ ] Update this README as the exercises are implemented and tested.

## Project Objective

The objective is to develop practical SQL Server skills by understanding not only how to write T-SQL statements, but also when and why to use Views, Indexes and Stored Procedures to solve realistic business and database problems.
