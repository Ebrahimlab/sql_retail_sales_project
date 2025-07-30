-- Project Implementation 
-- 1. Database Configuration

-- Database initialization
CREATE DATABASE Retail_Sales_db;


-- Table structure definition
USE Retail_Sales_db;
CREATE TABLE sales_records (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    total_sale DECIMAL(12,2)
);

SELECT TOP 10 * FROM sales_records;

SELECT COUNT(*) FROM sales_records;

-- 2. Data Quality Assurance 

-- Data volume verification
SELECT COUNT(*) AS total_transactions FROM sales_records;

-- Customer base analysis
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM sales_records;

-- Product category overview
SELECT DISTINCT category FROM sales_records;

-- Data integrity check
SELECT * FROM sales_records
WHERE sale_date IS NULL 
   OR customer_id IS NULL
   OR total_sale IS NULL;

-- Data cleansing
DELETE FROM sales_records
WHERE sale_date IS NULL
   OR customer_id IS NULL
   OR total_sale IS NULL;

-- Business Intelligence Queries 

-- 1. Basic Retrieval 
-- Daily transactions for November 5, 2022
SELECT *
FROM sales_records
WHERE sale_date = '2022-11-05';

-- Rename the column in SQL 
EXEC sp_rename 'sales_records.quantiy', 'quantity', 'COLUMN';

-- 2. Top Customers by Spending 
-- Top 10 customers by total spend (all categories)
SELECT 
    customer_id,
    COUNT(*) AS purchases,
    SUM(total_sale) AS total_spent
FROM sales_records
GROUP BY customer_id
ORDER BY total_spent DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


-- 3. Financial Metrics
-- Revenue by product line
SELECT 
    category,
    SUM(total_sale) AS category_revenue
FROM sales_records
GROUP BY category;


-- 4. Customer Insights 
-- Average age of clothing buyers
SELECT
    ROUND(AVG(age), 1) AS average_age
FROM sales_records
WHERE category = 'clothing';



-- 5. Premium Transactions
-- High-value purchases ($1000+)
SELECT * 
FROM sales_records
WHERE total_sale > 1000
ORDER BY total_sale DESC;


-- 6. Demographic Patterns
-- Transactions by gender and category
SELECT 
    category,
    gender,
    COUNT(*) AS transaction_count
FROM sales_records
GROUP BY category, gender;



-- 7. Temporal Analysis
-- Peak sales periods
WITH monthly_metrics AS (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM sales_records
    GROUP BY YEAR(sale_date), MONTH(sale_date)
)
SELECT year, month, avg_sale
FROM monthly_metrics
WHERE rank = 1;


-- 8. Customer Value
-- Top 5 spenders
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_spend
FROM sales_records
GROUP BY customer_id
ORDER BY total_spend DESC;



-- 9. Category Engagement
-- Unique customers per category
SELECT
   category,
    COUNT(DISTINCT customer_id) AS customer_count
FROM sales_records
GROUP BY category;



-- 10. Operational Patterns
-- -- Daily sales distribution
WITH time_analysis AS (
    SELECT *,
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) < 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS time_block
    FROM sales_records
)
SELECT 
    time_block,
    COUNT(*) AS transaction_volume
FROM time_analysis
GROUP BY time_block;

