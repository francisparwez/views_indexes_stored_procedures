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

-- Q4. Retrieve sorted View results
-- Problem: Management wants to see the newest registered customers first.
-- Task: Create vw_RecentUsers and retrieve users ordered by RegistrationDate descending.
-- Hint: ORDER BY , DESC . Apply sorting in the outer SELECT.
-- Explanation: The View stores the customer information. The outer query determines the display order. A View does not guarantee row ordering.

USE EcommerceDB;
GO

CREATE VIEW vw_RecentUsers AS
SELECT
    UserID,
    FirstName,
    LastName,
    RegistrationDate
FROM Users;
GO
SELECT * FROM vw_RecentUsers ORDER BY RegistrationDate DESC;

-- Q5. Create a View using INNER JOIN
-- Problem: The sales department wants customer names alongside their orders.
-- Task: Create vw_UserOrders .
-- Hint: Join Users and Orders on UserID

-- Explanation: INNER JOIN combines matching customer and order records.

USE EcommerceDB;
GO

CREATE VIEW vw_UserOrders AS
SELECT o.OrderID, u.UserID, u.FirstName, u.LastName, o.OrderDate, o.TotalAmount, o.OrderStatus
FROM Users u
    INNER JOIN Orders o ON u.UserID = o.UserID;
GO

SELECT * FROM vw_UserOrders;