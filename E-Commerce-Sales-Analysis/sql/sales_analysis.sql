CREATE DATABASE ecommerce_sales;
USE ecommerce_sales;
CREATE TABLE sales (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Customer_Name VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    Category VARCHAR(50),
    Product VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Percent DECIMAL(5,2),
    Payment_Mode VARCHAR(50),
    Sales DECIMAL(12,2),
    Profit DECIMAL(12,2)
);
USE ecommerce_sales;

LOAD DATA LOCAL INFILE
'C:/Users/Ganga Singh/OneDrive/Desktop/E-Commerce-Sales-Analysis/data/ecommerce_sales_cleaned.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Order_ID,
    Order_Date,
    Customer_Name,
    City,
    State,
    Category,
    Product,
    Quantity,
    Unit_Price,
    Discount_Percent,
    Payment_Mode,
    Sales,
    Profit
);
USE ecommerce_sales;

SELECT COUNT(*) AS total_rows
FROM ecommerce_sales_cleaned;

SELECT COUNT(*) AS total_rows
FROM sales;
USE ecommerce_sales;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Sales), 2) AS average_sales
FROM sales;
SELECT COUNT(*) AS rows_in_cleaned
FROM ecommerce_sales_cleaned;

SELECT COUNT(*) AS rows_in_sales
FROM sales;

SELECT COUNT(*) AS rows_in_cleaned
FROM ecommerce_sales_cleaned;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Sales), 2) AS average_sales
FROM ecommerce_sales_cleaned;

USE ecommerce_sales;

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM ecommerce_sales_cleaned
GROUP BY Category
ORDER BY total_sales DESC;

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS sales_month,
    ROUND(SUM(Sales), 2) AS monthly_sales,
    ROUND(SUM(Profit), 2) AS monthly_profit
FROM ecommerce_sales.ecommerce_sales_cleaned
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY sales_month;  

SELECT
    Payment_Mode,
    COUNT(*) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM ecommerce_sales.ecommerce_sales_cleaned
GROUP BY Payment_Mode
ORDER BY total_sales DESC;

SELECT
    Product,
    SUM(Quantity) AS total_quantity_sold,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM ecommerce_sales.ecommerce_sales_cleaned
GROUP BY Product
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit
FROM ecommerce_sales.ecommerce_sales_cleaned
GROUP BY Customer_Name
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT Order_ID) AS unique_orders
FROM ecommerce_sales.ecommerce_sales_cleaned;

SELECT
    SUM(Customer_Name IS NULL) AS missing_customer,
    SUM(City IS NULL) AS missing_city,
    SUM(Payment_Mode IS NULL) AS missing_payment
FROM ecommerce_sales.ecommerce_sales_cleaned;

SELECT
    Order_ID,
    COUNT(*) AS occurrences
FROM ecommerce_sales.ecommerce_sales_cleaned
GROUP BY Order_ID
HAVING COUNT(*) > 1;

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS sales_month,
    ROUND(SUM(Sales), 2) AS monthly_sales,
    ROUND(SUM(Profit), 2) AS monthly_profit
FROM ecommerce_sales_cleaned
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY sales_month;

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(
        SUM(Profit) * 100.0 / NULLIF(SUM(Sales), 0),
        2
    ) AS profit_margin_percent
FROM ecommerce_sales.ecommerce_sales_cleaned
GROUP BY Category
ORDER BY profit_margin_percent DESC;