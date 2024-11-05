

select * from [dbo].[LITA Capstone Dataset CSV];


--first create a revenue column by multiplying quantity and unit price
ALTER TABLE [dbo].[LITA Capstone Dataset CSV]
ADD revenue DECIMAL(10, 2)
UPDATE [dbo].[LITA Capstone Dataset CSV]
SET revenue = quantity * unitprice;

--retrieve the total sales for each product category.
SELECT Product, SUM(revenue) AS Total_Sales_by_Product
FROM [dbo].[LITA Capstone Dataset CSV]
GROUP BY product;

--find the number of sales transactions in each region
SELECT Region, SUM(revenue) AS Total_Sales_by_Product
FROM [dbo].[LITA Capstone Dataset CSV]
GROUP BY Region;

--find the highest-selling product by total sales value
SELECT TOP 1 product, SUM(revenue) AS Highest_Product_by_Sales
FROM [dbo].[LITA Capstone Dataset CSV] 
GROUP BY product
ORDER BY Highest_Product_by_Sales DESC;

--calculate total revenue per product
SELECT product, SUM(revenue) AS total_revenue_per_product
FROM [dbo].[LITA Capstone Dataset CSV]
GROUP BY product;

--calculate monthly sales totals for the current year
SELECT 
    DATENAME(MONTH, OrderDate) AS MonthName, 
    SUM(Quantity * UnitPrice) AS MonthlySales
FROM 
    [dbo].[LITA Capstone Dataset CSV]
WHERE 
    YEAR(OrderDate) = YEAR(GETDATE())
GROUP BY 
    DATENAME(MONTH, OrderDate), 
    MONTH(OrderDate)
ORDER BY 
    MONTH(OrderDate);

--find the top 5 customers by total purchase amount
SELECT TOP 5 customer_id, SUM(revenue) AS total_purchase_per_Customer
FROM [dbo].[LITA Capstone Dataset CSV]
GROUP BY customer_id
ORDER BY total_purchase_per_Customer DESC;

--calculate the percentage of total sales contributed by each region
WITH TotalSales AS (
    SELECT SUM(Revenue) AS total_sales
    FROM [dbo].[LITA Capstone Dataset CSV]
)
SELECT 
    region, 
    SUM(Revenue) AS region_sales, 
    (SUM(Revenue) / (SELECT total_sales FROM TotalSales)) * 100 AS percentage_sales
FROM [dbo].[LITA Capstone Dataset CSV]
GROUP BY region;


--identify products with no sales in the last quarter
SELECT 
    Product
FROM 
    [dbo].[LITA Capstone Dataset CSV]
WHERE 
    OrderDate < DATEADD(QUARTER, -1, GETDATE()) 
    AND Product NOT IN (
        SELECT Product 
        FROM [dbo].[LITA Capstone Dataset CSV]
        WHERE OrderDate >= DATEADD(QUARTER, -1, GETDATE())
    )
GROUP BY 
    Product;

