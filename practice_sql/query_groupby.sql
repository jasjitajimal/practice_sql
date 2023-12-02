/*********************************************
  SQL File: query_groupby.sql
  Description: This file demonstrates various uses of the GROUP BY clause in SQLite.
**********************************************/

/*************************************
  Table: sales
  Description: Stores information about sales transactions.
*************************************/
CREATE TABLE sales (
    sale_id INT PRIMARY KEY, -- Unique identifier for each sale
    product_name VARCHAR(50), -- Name of the product
    category VARCHAR(50), -- Category of the product
    sale_date DATE, -- Date of the sale
    quantity INT, -- Quantity sold
    total_amount DECIMAL(10, 2) -- Total amount of the sale
);

/*************************************
  Sample Data for sales Table
*************************************/
INSERT INTO sales (sale_id, product_name, category, sale_date, quantity, total_amount) VALUES
(1, 'Laptop', 'Electronics', '2022-01-10', 2, 1200.00),
(2, 'Smartphone', 'Electronics', '2022-02-15', 3, 900.00),
(3, 'Coffee Maker', 'Appliances', '2022-01-20', 1, 150.00),
(4, 'Headphones', 'Electronics', '2022-02-01', 2, 80.00),
(5, 'Blender', 'Appliances', '2022-03-05', 1, 50.00),
(6, 'Tablet', 'Electronics', '2022-01-25', 2, 300.00),
(7, 'Toaster', 'Appliances', '2022-02-10', 1, 30.00),
(8, 'Microwave', 'Appliances', '2022-03-15', 1, 120.00);

/*************************************
  SQL Queries: GROUP BY Examples
  Description: Demonstrates various uses of the GROUP BY clause.
*************************************/
-- Example 1: Grouping by a single column (Category) and calculating the total quantity sold in each category
SELECT category, SUM(quantity) AS total_quantity
FROM sales
GROUP BY category;

-- Example 2: Grouping by multiple columns (Category and Sale Date) and calculating the total amount and quantity sold for each combination
SELECT category, sale_date, SUM(quantity) AS total_quantity, SUM(total_amount) AS total_amount
FROM sales
GROUP BY category, sale_date;

-- Example 3: Using the HAVING clause to filter groups based on a condition (displaying categories with total quantity sold greater than 3)
SELECT category, SUM(quantity) AS total_quantity
FROM sales
GROUP BY category
HAVING total_quantity > 3;

-- Example 4: Grouping by a computed column (extracting the year from the sale date) and calculating the total quantity sold for each year
SELECT strftime('%Y', sale_date) AS sales_year, SUM(quantity) AS total_quantity
FROM sales
GROUP BY sales_year;