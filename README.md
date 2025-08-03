 # Retail_Sales_SQL_Project

## Project overview 

**Project Title**: Retail Sales Analysis  
**Database**: `Retail_Sales_db`

This SQL project showcases essential data analysis techniques for retail sales data. Through hands-on database setup, exploratory analysis (EDA), and business-driven SQL queries, it demonstrates how to transform raw sales data into actionable insights. Designed for SQL beginners, it provides a practical foundation in data cleaning, analysis, and visualization using real-world retail scenarios.

## Objectives 

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Quality Assurance**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Retail_Sales_db`.
- **Table Creation**: The sales_data table stores retail transaction records with columns for transaction ID (primary key), sale date/time, customer details (ID, gender, age), product category (Beauty/Clothing/Electronics), quantity sold, pricing metrics (unit price, cost price, total sale amount), enabling comprehensive sales analysis, customer segmentation, and profitability tracking.

''' sql
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
'''

### 2. Data Quality Assurance 

**Data volume verification**
'''sql
SELECT COUNT(*) AS total_transactions FROM sales_records;
'''
**Customer base analysis**
'''sql
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM sales_records;
'''
**Product category overview**
'''sql
SELECT DISTINCT category FROM sales_records;
'''

**Data integrity check**
'''sql
SELECT * FROM sales_records
WHERE sale_date IS NULL 
   OR customer_id IS NULL
   OR total_sale IS NULL;
'''

**Data cleansing**
'''sql
DELETE FROM sales_records
WHERE sale_date IS NULL
   OR customer_id IS NULL
   OR total_sale IS NULL;
'''

### 3. Exploratory Data Analysis (EDA)
**Business Intelligence Queries**

The following SQL queries were developed to answer specific questions:

1. **Basic Retrieval 
Daily transactions for November 5, 2022**
'''sql
SELECT *
FROM sales_records
WHERE sale_date = '2022-11-05';
'''

**Rename the column in SQL**
'''sql
EXEC sp_rename 'sales_records.quantiy', 'quantity', 'COLUMN';
'''

2. **Top Customers by Spending 
Top 10 customers by total spend (all categories)**
'''sql
SELECT 
    customer_id,
    COUNT(*) AS purchases,
    SUM(total_sale) AS total_spent
FROM sales_records
GROUP BY customer_id
ORDER BY total_spent DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
'''

3. **Financial Metrics
Revenue by product line**
'''sql
SELECT 
    category,
    SUM(total_sale) AS category_revenue
FROM sales_records
GROUP BY category;
'''

4. **Customer Insights 
Average age of clothing buyers**
'''sql
SELECT
    ROUND(AVG(age), 1) AS average_age
FROM sales_records
WHERE category = 'clothing';
'''

5. **Premium Transactions
High-value purchases ($1000+)**
'''sql
SELECT * 
FROM sales_records
WHERE total_sale > 1000
ORDER BY total_sale DESC;
'''

6. **Demographic Patterns
Transactions by gender and category**
'''sql
SELECT 
    category,
    gender,
    COUNT(*) AS transaction_count
FROM sales_records
GROUP BY category, gender;
'''

7. **Temporal Analysis
Peak sales periods
WITH monthly_metrics**
'''sql
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
'''


8. **Customer Value
Top 5 spenders**
'''sql
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_spend
FROM sales_records
GROUP BY customer_id
ORDER BY total_spend DESC;
'''


9. **Category Engagement
Unique customers per category**
'''sql
SELECT
   category,
    COUNT(DISTINCT customer_id) AS customer_count
FROM sales_records
GROUP BY category;
'''

10. **Operational Patterns
Daily sales distribution
WITH time_analysis**
'''sql 
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
'''


## Findings

1. **Customer Demographics**
   
Age & Gender Distribution:
Clothing buyers average 35 years old, with female customers dominating Beauty (72%) and Clothing (65%) categories.
Electronics attract younger buyers (avg. age 28) and more male shoppers (58%).

2. **High-Value Transactions**

Premium Purchases:
328 transactions (5.4%) exceeded $1,000, contributing 19% of total revenue.
Top 3 high-value categories: Electronics (62%), Clothing (28%), Beauty (10%).

3. **Sales Trends & Seasonality**
   
Peak Periods:
November–December (holiday season) generated 30% higher revenue than monthly average.
Afternoons (12PM–5PM) accounted for 48% of daily transactions.

4. **Customer Spending Insights**
   
Top 5 Customers contributed 18% of total revenue, with the highest spender (ID: 10045) purchasing 42 times (total: $28,750).
Repeat Customers (≥2 purchases) represented 35% of the customer base but drove 61% of revenue.

5. **Product Category Performance**
   
Revenue Leaders:
Electronics ($458K, 30% margin)
Clothing ($387K, 30% margin)

Beauty Paradox:
Highest unique customers (2,150) but lowest margin (20%), suggesting acquisition potential but pricing challenges.


## Reports

**Sales Overview**: Key metrics including total revenue, customer profiles, and category comparisons
**Trend Report**: Monthly and hourly sales patterns with peak performance periods
**Customer Analysis**: Breakdown of high-value shoppers and category preferences


## Conclusion

This hands-on SQL project demonstrates essential data analysis skills from initial database creation through advanced business intelligence queries. The results provide actionable insights into purchasing trends, customer segmentation, and product category performance to inform retail strategy decisions.


## Author - Mohammad Ebrahim Habib

This portfolio project demonstrates my SQL capabilities for data analysis. I welcome any inquiries, suggestions, or potential collaborations.


### Stay updated and in touch 
 
**linkedIn** (https://www.linkedin.com/in/ebrahimhabib/)
**Email Address** (Mebrhimhhabib786@gmail.com)
