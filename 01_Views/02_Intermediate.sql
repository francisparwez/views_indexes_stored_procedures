-- Q11. Create a View using LEFT JOIN
-- Problem:
--     Management wants a customer report that also includes customers who have never placed an order.
-- Task:
--     Create vw_AllCustomerOrders displaying customer names and their OrderID. Customers without orders must still appear.
-- Hint:
--     LEFT JOIN , NULL .

USE EcommerceDB;
GO

CREATE VIEW vw_AllCustomerOrders AS
SELECT u.UserID, u.FirstName, u.LastName, o.OrderID, o.OrderDate, o.TotalAmount
FROM Users u
    LEFT JOIN Orders o ON u.UserID = o.UserID;
GO

SELECT * FROM vw_AllCustomerOrders WHERE OrderID IS NULL;