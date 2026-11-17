-- Q1. Create your first View
-- Problem: Management frequently needs access to registered customer information.
-- Task: Create vw_Users displaying all columns from Users.
-- Hint: CREATE VIEW , AS , SELECT

-- Explanation: Creates a reusable virtual table based on the Users table. The View stores the
-- query definition, not a separate copy of the data.

USE EcommerceDB;
GO

CREATE VIEW vw_Users AS SELECT * FROM Users;
GO

SELECT * FROM vw_Users;