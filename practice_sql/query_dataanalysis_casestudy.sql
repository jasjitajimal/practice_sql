/*********************************************
  Script: query_data_analysis_case_studies.sql
  Description: Table creation for case studies demonstrating data analysis scenarios using SQL.
               Case studies demonstrating data analysis scenarios using SQL.
**********************************************/

-- Table: SalesData
CREATE TABLE IF NOT EXISTS SalesData (
    ProductID INT PRIMARY KEY,
    Category NVARCHAR(50),
    SalesAmount DECIMAL(10, 2)
);

-- Table: CustomerPurchaseSummary
CREATE TABLE IF NOT EXISTS CustomerPurchaseSummary (
    CustomerID INT PRIMARY KEY,
    TotalPurchaseAmount DECIMAL(10, 2)
);

-- Table: SalesTransactions
CREATE TABLE IF NOT EXISTS SalesTransactions (
    TransactionID INT PRIMARY KEY,
    TransactionDate DATE,
    Revenue DECIMAL(10, 2)
);

-- Table: Employees
CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
);

-- Table: EmployeeProjects
CREATE TABLE IF NOT EXISTS EmployeeProjects (
    EmployeeID INT REFERENCES Employees(EmployeeID),
    ProjectID INT PRIMARY KEY
);

-- Table: Products
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(255),
    CategoryID INT REFERENCES Categories(CategoryID)
);

-- Table: Categories
CREATE TABLE IF NOT EXISTS Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName NVARCHAR(255)
);

-- Table: OrderItems
CREATE TABLE IF NOT EXISTS OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT REFERENCES Orders(OrderID),
    ProductID INT REFERENCES Products(ProductID)
);

-- Table: Orders
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE
);

-- Table: Customers
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(255)
);

-- Table: Campaigns
CREATE TABLE IF NOT EXISTS Campaigns (
    CampaignID INT PRIMARY KEY,
    CampaignName NVARCHAR(255)
);

-- Table: CampaignResponses
CREATE TABLE IF NOT EXISTS CampaignResponses (
    CampaignResponseID INT PRIMARY KEY,
    CampaignID INT REFERENCES Campaigns(CampaignID),
    CustomerID INT REFERENCES Customers(CustomerID)
);

-- Table: Sales
CREATE TABLE IF NOT EXISTS Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT REFERENCES Customers(CustomerID),
    SalesAmount DECIMAL(10, 2)
);

-- Table: MarketingCampaigns
CREATE TABLE IF NOT EXISTS MarketingCampaigns (
    CampaignID INT PRIMARY KEY,
    CampaignName NVARCHAR(255),
    CampaignCost DECIMAL(10, 2)
);


-- Case Study 1: Sales Performance Analysis
-- Retrieve total sales amount for each product category.
-- Comments:
-- - Aggregating sales data to analyze performance.
-- - GROUP BY used for category-wise analysis.

SELECT
    Category,
    SUM(SalesAmount) AS TotalSales
FROM
    SalesData
GROUP BY
    Category;

-- Case Study 2: Customer Segmentation
-- Identify customer segments based on purchase behavior.
-- Comments:
-- - Using CASE statements to categorize customers.
-- - Segmentation based on total purchase amount.

SELECT
    CustomerID,
    TotalPurchaseAmount,
    CASE
        WHEN TotalPurchaseAmount >= 5000 THEN 'High Value'
        WHEN TotalPurchaseAmount >= 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS CustomerSegment
FROM
    CustomerPurchaseSummary;

-- Case Study 3: Monthly Revenue Trend
-- Analyze monthly revenue trends over a year.
-- Comments:
-- - Extracting month and year from the transaction date.
-- - GROUP BY and ORDER BY used for chronological analysis.

SELECT
    FORMAT(TransactionDate, 'MMM yyyy') AS MonthYear,
    SUM(Revenue) AS MonthlyRevenue
FROM
    SalesTransactions
GROUP BY
    FORMAT(TransactionDate, 'MMM yyyy')
ORDER BY
    FORMAT(TransactionDate, 'yyyy-MM');

-- Case Study 4: Employee Performance Evaluation
-- Evaluate employee performance based on completed projects.
-- Comments:
-- - JOIN operations to combine employee and project data.
-- - COUNT used to quantify the number of completed projects.

SELECT
    EmployeeID,
    FirstName,
    LastName,
    COUNT(ProjectID) AS CompletedProjects
FROM
    Employees
LEFT JOIN
    EmployeeProjects ON Employees.EmployeeID = EmployeeProjects.EmployeeID
GROUP BY
    EmployeeID, FirstName, LastName
ORDER BY
    CompletedProjects DESC;

-- Case Study 5: Product Popularity Analysis
-- Identify popular products based on the number of orders.
-- Comments:
-- - JOIN operations to combine products and order items data.
-- - COUNT used to quantify the popularity of each product.

SELECT
    ProductID,
    ProductName,
    COUNT(OrderID) AS OrderCount
FROM
    Products
LEFT JOIN
    OrderItems ON Products.ProductID = OrderItems.ProductID
GROUP BY
    ProductID, ProductName
ORDER BY
    OrderCount DESC;

-- Case Study 6: Customer Churn Analysis
-- Analyze customer churn based on order history.
-- Comments:
-- - Using LAG() function to identify consecutive order gaps.
-- - CASE statements to categorize customers as churned or active.

WITH CustomerOrderHistory AS (
    SELECT
        CustomerID,
        OrderDate,
        LAG(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS PreviousOrderDate
    FROM
        Orders
)
SELECT
    CustomerID,
    MIN(OrderDate) AS FirstOrderDate,
    MAX(OrderDate) AS LastOrderDate,
    CASE
        WHEN DATEDIFF(DAY, PreviousOrderDate, OrderDate) > 30 THEN 'Churned'
        ELSE 'Active'
    END AS CustomerStatus
FROM
    CustomerOrderHistory
GROUP BY
    CustomerID;

-- Case Study 7: Inventory Analysis
-- Analyze inventory turnover for each product.
-- Comments:
-- - Calculating inventory turnover ratio using formula.
-- - Identifying slow-moving and fast-moving products.

SELECT
    ProductID,
    ProductName,
    SUM(QuantitySold) AS TotalQuantitySold,
    AVG(StockOnHand) AS AverageStockOnHand,
    (SUM(QuantitySold) / AVG(StockOnHand)) AS InventoryTurnoverRatio
FROM
    Products
LEFT JOIN
    SalesTransactions ON Products.ProductID = SalesTransactions.ProductID
GROUP BY
    ProductID, ProductName
ORDER BY
    InventoryTurnoverRatio DESC;

-- Case Study 8: Geographic Sales Distribution
-- Analyze sales distribution across different regions.
-- Comments:
-- - GROUP BY used for region-wise sales analysis.
-- - Including relevant geographic information for better insights.

SELECT
    Region,
    Country,
    SUM(SalesAmount) AS TotalSales
FROM
    SalesData
GROUP BY
    Region, Country
ORDER BY
    TotalSales DESC;

-- Case Study 9: Time Series Forecasting
-- Forecast future sales using time series data.
-- Comments:
-- - Using window functions to calculate moving averages.
-- - Trend analysis for predicting future sales trends.

SELECT
    TransactionDate,
    SalesAmount,
    AVG(SalesAmount) OVER (ORDER BY TransactionDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MovingAverage
FROM
    SalesTransactions
ORDER BY
    TransactionDate;

-- Case Study 10: Marketing Campaign Effectiveness
-- Evaluate the effectiveness of marketing campaigns.
-- Comments:
-- - Calculating conversion rates and ROI for each campaign.
-- - JOIN operations to combine campaign and sales data.

SELECT
    CampaignID,
    CampaignName,
    COUNT(DISTINCT CustomerID) AS ConvertedCustomers,
    COUNT(DISTINCT SaleID) AS Sales,
    COUNT(DISTINCT SaleID) / COUNT(DISTINCT CustomerID) AS ConversionRate,
    (SUM(SalesAmount) - SUM(CampaignCost)) / SUM(CampaignCost) AS ReturnOnInvestment
FROM
    MarketingCampaigns
LEFT JOIN
    CampaignResponses ON MarketingCampaigns.CampaignID = CampaignResponses.CampaignID
LEFT JOIN
    Sales ON CampaignResponses.CustomerID = Sales.CustomerID
GROUP BY
    CampaignID, CampaignName;

-- End of Script

-- End of Table Creation
