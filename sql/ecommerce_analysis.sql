-- E-Commerce Customer & Sales Analysis
-- Tool: MySQL
-- Dataset: E-Commerce Customer Behavior Dataset

-- ============================================
-- 1. CUSTOMER OVERVIEW
-- ============================================

-- How many orders and unique customers are in the dataset?
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT Customer_ID) AS unique_customers
FROM ecommerce_data;

-- ============================================
-- 2. CUSTOMER PURCHASING BEHAVIOR
-- ============================================

-- How many orders does the average customer place?
SELECT
    COUNT(*) / COUNT(DISTINCT Customer_ID) AS avg_orders_per_customer
FROM ecommerce_data;


-- How many customers are one-time vs. repeat buyers?
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time customer'
        ELSE 'Repeat customer'
    END AS customer_type,
    COUNT(*) AS number_of_customers
FROM (
    SELECT
        Customer_ID,
        COUNT(*) AS order_count
    FROM ecommerce_data
    GROUP BY Customer_ID
) AS customer_orders
GROUP BY customer_type;

-- ============================================
-- 3. SALES PERFORMANCE
-- ============================================

-- Which product categories generate the most revenue?
SELECT
    Product_Category,
    SUM(Total_Amount) AS total_revenue,
    COUNT(*) AS number_of_orders,
    SUM(Total_Amount) / COUNT(*) AS avg_revenue_per_order
FROM ecommerce_data
GROUP BY Product_Category
ORDER BY total_revenue DESC;
-- ============================================
-- 4. MONTHLY SALES TRENDS
-- ============================================

SELECT
    DATE_FORMAT(Date, '%Y-%m') AS month,
    COUNT(*) AS number_of_orders,
    SUM(Total_Amount) AS monthly_revenue,
    AVG(Total_Amount) AS avg_order_value
FROM ecommerce_data
GROUP BY month
ORDER BY month;

