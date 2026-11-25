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

-- Q6. Create a View using three tables
-- Problem: Management wants customer, product and order information in one report.
-- Task: Create vw_OrderDetails .
-- Hint: Two INNER JOIN operations
-- Explanation: Combines three related tables through their foreign-key relationships.

USE EcommerceDB;
GO

CREATE VIEW vw_OrderDetails AS
SELECT o.OrderID, u.FirstName, u.LastName, p.ProductName, p.Category, o.OrderDate, o.TotalAmount, o.OrderStatus
FROM
    Orders o
    INNER JOIN Users u ON o.UserID = u.UserID
    INNER JOIN Products p ON o.ProductID = p.ProductID;
GO

SELECT * FROM vw_OrderDetails;

-- Q7. Count orders per customer
-- Problem: Management wants to know how many orders each customer has placed.
-- Task: Create vw_CustomerOrderCount .
-- Hint: COUNT() , GROUP BY .
-- Explanation: COUNT calculates the number of orders per customer. GROUP BY creates one result per UserID.

USE EcommerceDB;
GO

CREATE VIEW vw_CustomerOrderCount AS
SELECT UserID, COUNT(OrderID) AS TotalOrders
FROM Orders
GROUP BY
    UserID;
GO

SELECT * FROM vw_CustomerOrderCount;

-- Q8. Calculate customer revenue
-- Problem: Finance wants total order amounts grouped by customer.
-- Task:
--     Create vw_CustomerRevenue .
-- Hint:
--     SUM() , GROUP BY .
-- Explanation: SUM calculates each customer's total order amount. This example includes all order statuses.

USE EcommerceDB;
GO

CREATE VIEW vw_CustomerRevenue AS
SELECT UserID, SUM(TotalAmount) AS TotalRevenue
FROM Orders
GROUP BY
    UserID;
GO

SELECT * FROM vw_CustomerRevenue;

-- Q9. Modify an existing View
-- Problem: The original vw_Users contains unnecessary columns.
-- Task: Modify it to show only UserID, FirstName, LastName and City.
-- Hint:
--     ALTER VIEW

-- Explanation: ALTER VIEW replaces the existing View definition without needing to drop and recreate the object.

USE EcommerceDB;
GO

ALTER VIEW vw_Users AS
SELECT UserID, FirstName, LastName, City
FROM Users;
GO

SELECT * FROM vw_Users;