-- Check row count
SELECT 'DiscountData' AS TableName, COUNT(*) AS TotalRows FROM DiscountData
UNION ALL
SELECT 'ProductData', COUNT(*) FROM ProductData
UNION ALL
SELECT 'ProductSales', COUNT(*) FROM ProductSales;

-- Preview tables 
SELECT * FROM DiscountData;
SELECT * FROM ProductData;
SELECT * FROM ProductSales;

-- Check for null values 
SELECT 
    SUM(CASE WHEN Month IS NULL THEN 1 ELSE 0 END) AS Missing_Month,
    SUM(CASE WHEN Discount_Band IS NULL THEN 1 ELSE 0 END) AS Missing_Discount_Band,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS Missing_Discount
FROM DiscountData;

SELECT 
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Product_ID,
    SUM(CASE WHEN Product IS NULL THEN 1 ELSE 0 END) AS Missing_Product,
    SUM(CASE WHEN Cost_Price IS NULL THEN 1 ELSE 0 END) AS Missing_Cost_Price,
    SUM(CASE WHEN Sale_Price IS NULL THEN 1 ELSE 0 END) AS Missing_Sale_Price
FROM ProductData;

SELECT 
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Missing_Date,
    SUM(CASE WHEN Customer_Type IS NULL THEN 1 ELSE 0 END) AS Missing_Customer_Type,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Missing_Country,
    SUM(CASE WHEN Product IS NULL THEN 1 ELSE 0 END) AS Missing_Product,
    SUM(CASE WHEN Units_Sold IS NULL THEN 1 ELSE 0 END) AS Missing_Units_Sold
FROM ProductSales;

-- Check for duplicates 
SELECT Product_ID, COUNT(*) AS Duplicate_Count
FROM ProductData
GROUP BY Product_ID
HAVING COUNT(*) > 1;

-- Find row with missing data and remove row 
SELECT * 
FROM ProductSales
WHERE Product IS NULL;
DELETE FROM ProductSales
WHERE Customer_Type = 'Education'
AND Country = 'United States of America'
AND Product IS NULL;

-- Join ProductSales with ProductData
-- Format the Date column into separate Month and Year columns 
-- Create calculated columns: Revenue and Total_Cost
-- Join the result with DiscountData to include discount information
-- Create Discount_Revenue, based on discount percentages.
;WITH T1 AS (
    SELECT
        product.Product,
        product.Category,
        product.Brand,
        product.Description,
        product.Cost_Price,
        product.Sale_Price,
        product.Image_url,
        sales.Date,
        sales.Customer_Type,
        sales.Country, 
        sales.Discount_Band,
        sales.Units_Sold,
        (product.Sale_Price * sales.Units_Sold) AS Revenue,
        (product.Cost_Price * sales.Units_Sold) AS Total_Cost,  
        FORMAT(sales.Date, 'MMMM') AS Month,
        FORMAT(sales.Date, 'yyyy') AS Year
    FROM ProductData product
    JOIN ProductSales sales
    ON product.Product_ID = sales.Product
)

SELECT 
* ,
(1 - Discount * 1.0 / 100) * Revenue as Discount_Revenue
FROM T1 a
JOIN DiscountData b
on a.Discount_Band = b.Discount_Band and a.month = b.month 

-- Basic Statistics for Revenue, Total_Cost, and Units_Sold
;WITH T1 AS (
    SELECT
        product.Product,
        product.Category,
        product.Brand,
        product.Description,
        product.Cost_Price,
        product.Sale_Price,
        product.Image_url,
        sales.Date,
        sales.Customer_Type,
        sales.Country,
        sales.Discount_Band,
        sales.Units_Sold,
        (product.Sale_Price * sales.Units_Sold) AS Revenue,
        (product.Cost_Price * sales.Units_Sold) AS Total_Cost,
        FORMAT(sales.Date, 'MMMM') AS Sales_Month,
        FORMAT(sales.Date, 'yyyy') AS Sales_Year
    FROM ProductData product
    JOIN ProductSales sales ON product.Product_ID = sales.Product
),
Discounted_Revenue AS (
    SELECT
        T1.*,
        DiscountData.Discount,
        (1 - DiscountData.Discount * 1.0 / 100) * T1.Revenue AS Discount_Revenue
    FROM T1
    JOIN DiscountData ON T1.Discount_Band = DiscountData.Discount_Band AND T1.Sales_Month = DiscountData.Month
)
SELECT
    AVG(Revenue) AS Average_Revenue,
    MIN(Revenue) AS Min_Revenue,
    MAX(Revenue) AS Max_Revenue,
    AVG(Total_Cost) AS Average_Cost,
    MIN(Total_Cost) AS Min_Cost,
    MAX(Total_Cost) AS Max_Cost,
    AVG(Units_Sold) AS Average_Units,
    MIN(Units_Sold) AS Min_Units,
    MAX(Units_Sold) AS Max_Units
FROM Discounted_Revenue;

-- Categorical Data Analysis for Product, Customer_Type, and Country
SELECT Product, COUNT(*) AS Frequency, COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Percentage
FROM ProductSales
GROUP BY Product
ORDER BY Frequency DESC;

SELECT Customer_Type, COUNT(*) AS Frequency, COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Percentage
FROM ProductSales
GROUP BY Customer_Type
ORDER BY Frequency DESC;

SELECT Country, COUNT(*) AS Frequency, COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Percentage
FROM ProductSales
GROUP BY Country
ORDER BY Frequency DESC;

-- Distribution of Discounts
SELECT
    Discount_Band,
    COUNT(*) AS Frequency,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS Percentage
FROM ProductSales
GROUP BY Discount_Band
ORDER BY Frequency DESC;