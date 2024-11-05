Create Database CustomerData;

use CustomerData;

select * from [dbo].[2];

--retrieve the total number of customers from each region
SELECT Region, COUNT(CustomerID) AS total_customers
FROM [dbo].[2]
GROUP BY region;

--find the most popular subscription type by the number of customers
SELECT Top 1 subscriptionType, COUNT(CustomerID) AS total_customers
FROM [dbo].[2]
GROUP BY SubscriptionType
ORDER BY total_customers DESC

--find customers who canceled their subscription within 6 months
SELECT CustomerID, CustomerName, SubscriptionType, SubscriptionStart, SubscriptionEnd
FROM [dbo].[2]
WHERE Canceled = 1 AND DATEDIFF(month, SubscriptionStart, SubscriptionEnd) <= 6;

--calculate the average subscription duration for all customers
SELECT AVG(DATEDIFF(day, SubscriptionStart, SubscriptionEnd)) AS AvgSubscriptionDurationDays
FROM [dbo].[2];

--Find customers with subscriptions longer than 12 months
SELECT CustomerID, CustomerName, SubscriptionType, SubscriptionStart, SubscriptionEnd
FROM [dbo].[2]
WHERE DATEDIFF(month, SubscriptionStart, SubscriptionEnd) > 12;

--Calculate total revenue by subscription type
SELECT SubscriptionType, SUM(Revenue) AS TotalRevenue
FROM [dbo].[2]
GROUP BY SubscriptionType;

-- Find the top 3 regions by subscription cancellations
SELECT TOP 3 Region, COUNT(CustomerID) AS TotalCancellations
FROM [dbo].[2]
WHERE Canceled = 1
GROUP BY Region
ORDER BY TotalCancellations DESC;

-- Find the total number of active and canceled subscriptions
SELECT 
    SUM(CASE WHEN Canceled = 0 THEN 1 ELSE 0 END) AS ActiveSubscriptions,
    SUM(CASE WHEN Canceled = 1 THEN 1 ELSE 0 END) AS CanceledSubscriptions
FROM [dbo].[2];