-- ================================================
-- Olist E-Commerce — Data Quality Health Check
-- Author: Adnan Mustafa
-- Database: MySQL (Aiven Console)
-- ================================================

USE olist_ecommerce;

-- 1. Row counts for all tables
SELECT 'Sales_Data' AS TableName, COUNT(*) AS `Rows` FROM Sales_Data
UNION ALL
SELECT 'Customer_Lookup', COUNT(*) FROM Customer_Lookup
UNION ALL
SELECT 'Product_Lookup', COUNT(*) FROM Product_Lookup
UNION ALL
SELECT 'Seller_Lookup', COUNT(*) FROM Seller_Lookup
UNION ALL
SELECT 'Reviews_Lookup', COUNT(*) FROM Reviews_Lookup;

-- 2. Check DeliveryDate values
SELECT DeliveryDate, COUNT(*) AS Count
FROM Sales_Data
GROUP BY DeliveryDate
ORDER BY Count DESC
LIMIT 10;

-- 3. Check CustomerID format in Sales_Data
SELECT CustomerID FROM Sales_Data LIMIT 5;

-- 4. Check CustomerID format in Customer_Lookup
SELECT CustomerID FROM Customer_Lookup LIMIT 5;

-- 5. Check duplicate CustomerID in Customer_Lookup
SELECT CustomerID, COUNT(*) AS Count
FROM Customer_Lookup
GROUP BY CustomerID
HAVING Count > 1;

-- 6. Referential integrity: CustomerID
SELECT COUNT(*) AS MissingCustomers
FROM Sales_Data s
LEFT JOIN Customer_Lookup c ON s.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- 7. Referential integrity: ProductID
SELECT COUNT(*) AS MissingProducts
FROM Sales_Data s
LEFT JOIN Product_Lookup p ON s.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- 8. Referential integrity: SellerID
SELECT COUNT(*) AS MissingSellers
FROM Sales_Data s
LEFT JOIN Seller_Lookup sl ON s.SellerID = sl.SellerID
WHERE sl.SellerID IS NULL;

-- 9. Referential integrity: OrderID in Reviews_Lookup
SELECT COUNT(*) AS MissingOrders
FROM Reviews_Lookup r
LEFT JOIN Sales_Data s ON r.OrderID = s.OrderID
WHERE s.OrderID IS NULL;

-- 10. Sample Sales_Data
SELECT * FROM Sales_Data LIMIT 5;
