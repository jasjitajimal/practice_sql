/*********************************************
  SQL File: query_having.sql
  Description: This file demonstrates various uses of the HAVING clause in SQLite.
**********************************************/

/*************************************
  Table: orders
  Description: Stores information about customer orders.
*************************************/
CREATE TABLE orders (
    order_id INT PRIMARY KEY, -- Unique identifier for each order
    customer_id INT, -- Customer identifier
    order_date DATE, -- Date of the order
    total_amount DECIMAL(10, 2) -- Total amount of the order
);

/*************************************
  Sample Data for orders Table
*************************************/
INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 101, '2022-01-10', 1200.00),
(2, 102, '2022-02-15', 900.00),
(3, 103, '2022-01-20', 150.00),
(4, 101, '2022-02-01', 80.00),
(5, 102, '2022-03-05', 50.00),
(6, 103, '2022-01-25', 300.00),
(7, 101, '2022-02-10', 30.00),
(8, 102, '2022-03-15', 120.00);

/*************************************
  SQL Queries: HAVING Examples
  Description: Demonstrates various uses of the HAVING clause.
*************************************/
-- Example 1: Filtering groups based on a condition (displaying customers with total orders greater than 2)
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING total_orders > 2;

-- Example 2: Using aggregate functions in HAVING clause (displaying customers with average order amount greater than 100)
SELECT customer_id, AVG(total_amount) AS average_order_amount
FROM orders
GROUP BY customer_id
HAVING average_order_amount > 100;

-- Example 3: Combining HAVING and WHERE clauses (displaying customers with total orders greater than 1 and total amount greater than 200)
SELECT customer_id, COUNT(order_id) AS total_orders, SUM(total_amount) AS total_amount
FROM orders
WHERE order_date >= '2022-01-01' AND order_date < '2022-03-01'
GROUP BY customer_id
HAVING total_orders > 1 AND total_amount > 200;

-- Example 4: Using HAVING with a computed column (displaying years with total orders greater than 2)
SELECT strftime('%Y', order_date) AS order_year, COUNT(order_id) AS total_orders
FROM orders
GROUP BY order_year
HAVING total_orders > 2;