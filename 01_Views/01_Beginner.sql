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

--Q2. Select specific columns
--Problem: Marketing only requires customer contact information.
--Task: Create vw_UserContactDetails containing UserID, FirstName, LastName, Email and
--City.
--Hint: Explicitly specify columns in SELECT.

--Explanation: Only the selected columns are exposed through the View. This makes the
--output more focused and can help limit unnecessary data exposure.

USE EcommerceDB;
GO

CREATE VIEW vw_UserContactDetails AS
SELECT
    UserID,
    FirstName,
    LastName,
    Email,
    City
FROM Users;
GO

SELECT * FROM vw_UserContactDetails;

--Q3. Create a filtered View
--Problem: Marketing wants a list of customers registered in Karachi.
--Task: Create vw_KarachiUsers
--Hint: WHERE

--Explanation: The WHERE clause filters records. Only Karachi customers appear when
--querying this View.

USE EcommerceDB;
GO

CREATE VIEW vw_KarachiUsers AS
SELECT *
FROM Users
WHERE
    City = 'Karachi';
GO

SELECT * FROM vw_KarachiUsers;