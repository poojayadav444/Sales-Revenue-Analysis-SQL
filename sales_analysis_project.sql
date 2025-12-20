CREATE DATABASE IF NOT EXISTS sales_revenue_analysis;
USE sales_revenue_analysis;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price INT
);

CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Pooja', 'Bangalore'),
(2, 'Ravi', 'Hyderabad'),
(3, 'Anil', 'Chennai'),
(4, 'Sneha', 'Bangalore'),
(5, 'Kiran', 'Hyderabad');


INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 60000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Headphones', 'Accessories', 3000),
(104, 'Keyboard', 'Accessories', 1500);


INSERT INTO sales VALUES
(1001, 1, 101, 1, '2024-01-10'),
(1002, 2, 102, 2, '2024-01-15'),
(1003, 1, 102, 1, '2024-02-05'),
(1004, 3, 103, 3, '2024-02-20'),
(1005, 4, 101, 1, '2024-03-12'),
(1006, 5, 104, 2, '2024-03-18'),
(1007, 2, 101, 1, '2024-03-25');

#Total Revenue (Overall)
SELECT 
    SUM(p.price * s.quantity) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id;

#Monthly Sales Trend

SELECT 
    MONTH(s.order_date) AS month,
    SUM(p.price * s.quantity) AS monthly_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY MONTH(s.order_date)
ORDER BY month;

#Top Products by Revenue

SELECT 
    p.product_name,
    SUM(p.price * s.quantity) AS product_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY product_revenue DESC;

#Top Customers by Spending

SELECT 
    c.customer_name,
    SUM(p.price * s.quantity) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

#City-wise Revenue Analysis

SELECT 
    c.city,
    SUM(p.price * s.quantity) AS city_revenue
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.city
ORDER BY city_revenue DESC;

#Category-wise Revenue

SELECT 
    p.category,
    SUM(p.price * s.quantity) AS category_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;










