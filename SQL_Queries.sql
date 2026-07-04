
--Select*to understand tables


CREATE DATABASE ecommerce;
USE ecommerce;

 
-- ==========================================
-- Requirement 1: Explore the Dataset
-- ==========================================

-- Query 1: Display the first 10 records from the customers table.
-- Explanation:
-- This query helps understand the customer data, available columns, and data structure.

SELECT TOP 10 *
FROM customers;

-- Query 2: Display the first 10 records from the orders table.
-- Explanation:
-- This query helps understand order details and order status.

SELECT TOP 10 *
FROM orders;

-- Query 3: Display the first 10 records from the order_items table.
-- Explanation:
-- This query shows purchased products, prices, and shipping charges.

SELECT TOP 10 *
FROM order_items;

-- Query 4: Display the first 10 records from the products table.
-- Explanation:
-- This query helps understand product information and product categories.

SELECT TOP 10 *
FROM products;

-- Query 5: Display the first 10 records from the order_payments table.
-- Explanation:
-- This query shows payment methods and payment values used by customers.

SELECT TOP 10 *
FROM order_payments;
---Use Aggregation Functions (COUNT, SUM, AVG) and GROUP BY:




-- ==========================================
-- Requirement 2: Aggregation Functions
-- ==========================================

-- Query 1: Count customers by state.
-- Explanation:
-- This query counts the number of customers in each state.
-- It helps identify states with the largest customer base.
SELECT
    customer_state,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY customer_state
ORDER BY Total_Customers DESC;


-- Query 2: Count orders by status.
-- Explanation:
-- This query counts orders based on their current status.
-- It helps monitor order processing and delivery performance.
SELECT
    order_status,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY order_status
ORDER BY Total_Orders DESC;


-- Query 3: Calculate total revenue.
-- Explanation:
-- This query calculates the total payment received from all orders.
-- It helps measure the overall business revenue.
SELECT
    SUM(payment_value) AS Total_Revenue
FROM order_payments;


-- Query 4: Calculate average payment value.
-- Explanation:
-- This query calculates the average amount paid per order.
-- It helps understand customer spending patterns.
SELECT
    AVG(payment_value) AS Average_Payment
FROM order_payments;

-- Query 5: Count payment methods.
-- Explanation:
-- This query counts how many times each payment method was used.
-- It helps identify the most preferred payment method.
SELECT
    payment_type,
    COUNT(*) AS Total_Transactions
FROM order_payments
GROUP BY payment_type
ORDER BY Total_Transactions DESC;



-- Query 6: Calculate the average product price.
-- Explanation:
-- This query calculates the average price of all products in the order_items table.
-- It helps understand the average selling price and supports pricing analysis.
SELECT
    AVG(price) AS Average_Product_Price
FROM order_items;


-- Query 7: Calculate the total shipping cost.
-- Explanation:
-- This query calculates the total shipping (freight) cost for all orders.
-- It helps analyze the overall shipping expenses of the business.
SELECT
    SUM(freight_value) AS Total_Shipping_Cost
FROM order_items;



-- Query 8: Count products by category.
-- Explanation:
-- This query counts the number of products in each category.
-- It helps understand product distribution across categories.
SELECT
    product_category_name,
    COUNT(*) AS Total_Products
FROM products
GROUP BY product_category_name
ORDER BY Total_Products DESC;




--Requirement 3: JOIN Operations
-- Query 1: Show customer details with their orders.
-- Explanation:
-- This query joins the customers and orders tables using customer_id.
-- It shows which customer placed each order and its current order status.

SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;




-- Query 2: Show orders with payment details.
-- Explanation:
-- This query joins the orders and order_payments tables using order_id.
-- It displays the payment method and payment amount for each order.

SELECT
    o.order_id,
    o.order_status,
    p.payment_type,
    p.payment_value
FROM orders AS o
INNER JOIN order_payments AS p
ON o.order_id = p.order_id;



-- Query 3: Show products purchased in each order.
-- Explanation:
-- This query joins the order_items and products tables using product_id.
-- It displays the products included in each order.

SELECT
    oi.order_id,
    oi.product_id,
    oi.price,
    oi.freight_value,
    p.product_category_name
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id;




-- Query 4: Show customer orders with payment details.
-- Explanation:
-- This query combines customers, orders, and payments tables.
-- It helps identify how each customer paid for their orders.

SELECT
    c.customer_id,
    c.customer_city,
    o.order_id,
    p.payment_type,
    p.payment_value
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_payments AS p
ON o.order_id = p.order_id;




-- Query 5: Find top customers by revenue.
-- Explanation:
-- This query calculates the total revenue generated by each customer.
-- It helps identify high-value customers.
SELECT
    c.customer_id,
    c.customer_city,
    SUM(p.payment_value) AS Total_Revenue
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_payments AS p
ON o.order_id = p.order_id
GROUP BY
    c.customer_id,
    c.customer_city
ORDER BY Total_Revenue DESC;




-- Query 6: Calculate revenue by customer state.
-- Explanation:
-- This query calculates the total revenue generated from each state.
-- It helps identify the highest revenue-generating regions.
SELECT
    c.customer_state,
    SUM(p.payment_value) AS Total_Revenue
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_payments AS p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY Total_Revenue DESC;




-- Query 7: Find the most sold product categories.
-- Explanation:
-- This query counts the number of products sold in each category.
-- It helps identify the most popular product categories.

SELECT
    p.product_category_name,
    COUNT(*) AS Total_Sold
FROM order_items AS oi
INNER JOIN products AS p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY Total_Sold DESC;


-- Query 8: Display complete order information.
-- Explanation:
-- This query combines customer, order, payment, and product information.
-- It provides a complete view of each order for business analysis.
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status,
    p.payment_type,
    p.payment_value,
    pr.product_category_name,
    oi.price,
    oi.freight_value
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
INNER JOIN order_payments AS p
ON o.order_id = p.order_id
INNER JOIN order_items AS oi
ON o.order_id = oi.order_id
INNER JOIN products AS pr
ON oi.product_id = pr.product_id;








--Subqueries


-- Query 1: Show orders with payment greater than the average payment.
-- Explanation:
-- This query uses a subquery to calculate the average payment value.
-- It returns only those orders whose payment is higher than the average payment.

SELECT
    order_id,
    payment_value
FROM order_payments
WHERE payment_value >
(
    SELECT AVG(payment_value)
    FROM order_payments
);


-- Query 2: Show products heavier than the average product weight.
-- Explanation:
-- This query compares each product's weight with the average product weight.
-- It returns products that are heavier than the average.

SELECT
    product_id,
    product_category_name,
    product_weight_g
FROM products
WHERE product_weight_g >
(
    SELECT AVG(product_weight_g)
    FROM products
); 




-- Query 3: Show customers from states having more than 1000 customers.
-- Explanation:
-- This query uses a subquery with GROUP BY and HAVING to identify states
-- that have more than 1000 customers. It then displays the customers
-- belonging to those states.

SELECT
    customer_id,
    customer_state
FROM customers
WHERE customer_state IN
(
    SELECT customer_state
    FROM customers
    GROUP BY customer_state
    HAVING COUNT(*) > 1000
);



-- Query 4: Show orders with product price greater than the average price.
-- Explanation:
-- This query finds products whose selling price is above the average price.
-- It helps identify high-priced products.

SELECT
    order_id,
    product_id,
    price
FROM order_items
WHERE price >
(
    SELECT AVG(price)
    FROM order_items
);



-- Query 5: Show product categories having more than 100 products.
-- Explanation:
-- This query uses a subquery with GROUP BY and HAVING.
-- It returns categories that contain more than 100 products.

SELECT
    product_category_name
FROM products
WHERE product_category_name IN
(
    SELECT product_category_name
    FROM products
    GROUP BY product_category_name
    HAVING COUNT(*) > 100
);








-- ==========================================
-- Requirement 5: Query Optimization
-- ==========================================

-- Example 1: Using SELECT * (Not Recommended)
-- Explanation:
-- This query retrieves all columns from the customers table.
-- It may return unnecessary data and can reduce query performance.

SELECT *
FROM customers;

-- Example 2: Selecting Only Required Columns (Recommended)
-- Explanation:
-- This query retrieves only the required columns instead of all columns.
-- Selecting only the necessary columns improves query performance and reduces memory usage.

SELECT
    customer_id,
    customer_city,
    customer_state
FROM customers;

