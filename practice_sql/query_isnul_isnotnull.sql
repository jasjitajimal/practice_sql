/*********************************************
  Script: query_isnull_isnotnull.sql
  Description: Examples demonstrating the use of IS NULL and IS NOT NULL conditions with created tables.
**********************************************/

-- Create a table for employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name NVARCHAR(50),
    department NVARCHAR(50),
    salary DECIMAL(10, 2),
    manager_id INT,
    email NVARCHAR(100)
);


-- Insert data into the 'employees' table
INSERT INTO employees VALUES
    (1, 'John Doe', 'IT', 60000.00, NULL, 'john.doe@company.com'),
    (2, 'Jane Smith', 'HR', 55000.00, 1, 'jane.smith@company.com'),
    (3, 'Bob Johnson', 'Finance', 70000.00, 1, NULL),
    (4, 'Alice Williams', 'Marketing', NULL, 2, 'alice.williams@company.com');

-- Create a table for tasks
CREATE TABLE tasks (
    task_id INT PRIMARY KEY,
    task_description NVARCHAR(100),
    start_date DATE,
    end_date DATE
);

-- Insert data into the 'tasks' table
INSERT INTO tasks VALUES
    (1, 'Project A', '2023-01-01', '2023-02-01'),
    (2, 'Project B', NULL, '2023-03-01'),
    (3, 'Project C', '2023-04-01', NULL),
    (4, 'Project D', NULL, NULL);

-- Create a table for orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    shipped_date DATE
);

-- Insert data into the 'orders' table
INSERT INTO orders VALUES
    (101, '2023-01-01', '2023-01-10'),
    (102, '2023-02-01', '2023-02-05'),
    (103, '2023-03-01', NULL),
    (104, '2023-04-01', '2023-04-10');

-- Create a table for customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name NVARCHAR(50)
);

-- Insert data into the 'customers' table
INSERT INTO customers VALUES
    (1, 'Customer A'),
    (2, 'Customer B'),
    (3, 'Customer C'),
    (4, 'Customer D');

-- Create a table for products
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name NVARCHAR(50),
    unit_price DECIMAL(10, 2),
    category_id INT
);

-- Insert data into the 'products' table
INSERT INTO products VALUES
    (1, 'Product A', 20.00, 1),
    (2, 'Product B', 30.00, 2),
    (3, 'Product C', 25.00, NULL),
    (4, 'Product D', 40.00, 1);

-- Create a table for suppliers
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name NVARCHAR(50)
);

-- Insert data into the 'suppliers' table
INSERT INTO suppliers VALUES
    (1, 'Supplier X'),
    (2, 'Supplier Y'),
    (3, 'Supplier Z'),
    (4, 'Supplier W');

-- Example 1: Basic use of IS NULL
-- Selects all records from the 'employees' table where the 'department' is NULL.
SELECT * FROM employees
WHERE department IS NULL;

-- Example 2: Basic use of IS NOT NULL
-- Selects all records from the 'employees' table where the 'salary' is NOT NULL.
SELECT * FROM employees
WHERE salary IS NOT NULL;

-- Example 3: Using IS NULL with aggregate function
-- Counts the number of employees in each department where the 'manager_id' is NULL.
SELECT department, COUNT(*) AS total_employees
FROM employees
WHERE manager_id IS NULL
GROUP BY department;

-- Example 4: Using IS NOT NULL with LIKE condition
-- Selects employee names from the 'employees' table where the 'email' is NOT NULL and contains '@company.com'.
SELECT employee_name
FROM employees
WHERE email IS NOT NULL AND email LIKE '%@company.com';

-- Example 5: Combining IS NULL and IS NOT NULL with OR
-- Selects all records from the 'tasks' table where the 'start_date' is NULL or 'end_date' is NOT NULL.
SELECT *
FROM tasks
WHERE start_date IS NULL OR end_date IS NOT NULL;

-- Example 6: Using IS NULL in a CASE statement
-- Classifies employees as 'New Hire' or 'Existing Employee' based on whether the 'hire_date' is NULL.
SELECT employee_id, employee_name,
  CASE
    WHEN hire_date IS NULL THEN 'New Hire'
    ELSE 'Existing Employee'
  END AS employee_status
FROM employees;

-- Example 7: Using IS NOT NULL in a CASE statement
-- Classifies orders as 'Shipped' or 'Not Shipped' based on whether the 'shipped_date' is NOT NULL.
SELECT order_id, order_date,
  CASE
    WHEN shipped_date IS NOT NULL THEN 'Shipped'
    ELSE 'Not Shipped'
  END AS order_status
FROM orders;

-- Example 8: Using IS NULL in a JOIN condition
-- Selects customers and their orders where there is no corresponding order (order_id is NULL).
SELECT customers.customer_id, customers.customer_name, orders.order_id
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.order_id IS NULL;

-- Example 9: Using IS NOT NULL in a subquery
-- Selects products with a 'unit_price' greater than the average unit price of products with a NOT NULL 'category_id'.
SELECT product_id, product_name, unit_price
FROM products
WHERE unit_price > (SELECT AVG(unit_price) FROM products WHERE category_id IS NOT NULL);

-- Example 10: Using IS NULL in a subquery
-- Selects suppliers with no products in the 'products' table where 'category_id' is NULL.
SELECT supplier_id, supplier_name
FROM suppliers
WHERE NOT EXISTS (SELECT 1 FROM products WHERE products.supplier_id = suppliers.supplier_id AND category_id IS NULL);


-- End of Script
