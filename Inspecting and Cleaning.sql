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

-- Find row with missing data and Remove row 
SELECT * 
FROM ProductSales
WHERE Product IS NULL;
DELETE FROM ProductSales
WHERE Customer_Type = 'Education'
AND Country = 'United States of America'
AND Product IS NULL;


-- 1: Join ProductSales with ProductData
-- 2: Format the Date column into separate Month and Year columns 
-- 3: Create calculated columns: Revenue and Total_Cost
-- 4: Join the result with DiscountData to include discount information
-- 5: Create Discount_Revenue, based on discount percentages.
WITH T1 AS (
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