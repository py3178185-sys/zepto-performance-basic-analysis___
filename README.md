# Zepto Product Performance & Sales Analysis using SQL

## 📌 Project Overview

This project focuses on analyzing Zepto product data using SQL and PostgreSQL.

The objective of this project is to perform data cleaning, product analysis, inventory analysis, discount analysis, and revenue analysis to derive meaningful business insights from the dataset.

---

## 🛠️ Tools & Technologies

- PostgreSQL
- SQL
- pgAdmin 4
- CSV Dataset

---

## 📊 Dataset

The dataset contains Zepto product-level information such as:

- SKU ID
- Product Category
- Product Name
- MRP
- Discount Percentage
- Available Quantity
- Discounted Selling Price
- Product Weight
- Out-of-Stock Status
- Quantity Sold

---

## 🧹 Data Cleaning & Preparation

Before performing the analysis, the dataset was checked and prepared using SQL.

The following data-cleaning tasks were performed:

- Checked the total number of records
- Identified NULL values
- Identified unique product categories
- Checked products that were in stock and out of stock
- Identified duplicate product names
- Identified products having zero MRP or selling price
- Removed products with zero MRP
- Corrected column naming issues
- Converted price values from paise to rupees

---

## 🔍 Business Questions & Analysis

### 1. Top 10 Best-Value Products

Identified the top 10 products based on their discount percentage.

### 2. High-MRP Products That Are Out of Stock

Identified products with an MRP greater than ₹300 that are currently out of stock.

### 3. Estimated Revenue by Category

Calculated estimated revenue for each product category using:

**Discounted Selling Price × Available Quantity**

### 4. Products With High MRP and Low Discount

Identified products with:

- MRP greater than ₹500
- Discount percentage less than 10%

### 5. Top 5 Categories With Highest Average Discount

Calculated the average discount percentage for each category and identified the top 5 categories.

### 6. Most Sold Product

Identified the product with the highest total quantity sold.

### 7. Price Per Gram Analysis

Calculated the price per gram for products weighing 100 grams or more to identify better-value products.

**Price Per Gram = Discounted Selling Price / Weight in Grams**

### 8. Product Weight Classification

Grouped products into three weight categories:

- Low
- Medium
- Bulk

Based on product weight.

### 9. Total Inventory Weight by Category

Calculated the total inventory weight available in each category.

**Total Inventory Weight = Product Weight × Available Quantity**

### 10. Category With Lowest Average Inventory

Identified the category having the lowest average available inventory.

### 11. Products With Low Discounts but High Sales

Identified products with less than 10% discount but comparatively high sales quantity.

### 12. Revenue and Discount Analysis by Category

Compared categories based on:

- Total Revenue
- Average Discount Percentage

This analysis helps understand the relationship between revenue generation and discount levels.

---

## 🧠 SQL Concepts Used

The project demonstrates the following SQL concepts:

- SELECT
- WHERE
- DISTINCT
- ORDER BY
- GROUP BY
- HAVING
- LIMIT
- COUNT()
- SUM()
- AVG()
- ROUND()
- CASE WHEN
- ALTER TABLE
- UPDATE
- DELETE
- CTE (Common Table Expression)
- Subqueries
- Aggregate Functions
- Mathematical Calculations
- Data Filtering
- Data Cleaning

---

## 💡 Key Business Insights

This project demonstrates how SQL can be used to analyze:

- Product pricing
- Discount strategies
- Product sales performance
- Category performance
- Revenue generation
- Inventory levels
- Product value based on price per gram
- Out-of-stock products
- Relationship between discounts and sales

---

# Zepto Product Performance & Sales Analysis using SQL

## 📌 Project Overview

This project focuses on analyzing Zepto product data using **PostgreSQL
and SQL**.

The objective is to clean the dataset and answer practical business
questions related to **product pricing, discounts, sales, revenue,
inventory, product weight, and category performance**.

------------------------------------------------------------------------

## 🛠️ Tools & Technologies

-   **PostgreSQL**
-   **SQL**
-   **pgAdmin 4**
-   **CSV Dataset**

------------------------------------------------------------------------

## 📂 Project Files

-   `ZEPTO_basic project.sql` --- SQL queries for data cleaning and
    business analysis
-   `ZEPTO4_FINAL.csv` --- Dataset used for the analysis

------------------------------------------------------------------------

# 🧹 Data Cleaning & Preparation

Before performing the business analysis, the dataset was checked and
prepared using SQL.

### 1. Create the table

``` sql
CREATE TABLE zepto_(
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(30),
    name VARCHAR(130) NOT NULL,
    mrp NUMERIC(8,2),
    discountpercent NUMERIC(5,2),
    availablequantity INTEGER,
    discountedsellingprice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);
```

### 2. Check total number of rows

``` sql
SELECT COUNT(*)
FROM zepto_;
```

### 3. Check for NULL values

``` sql
SELECT *
FROM zepto_
WHERE name IS NULL
   OR category IS NULL
   OR mrp IS NULL
   OR discountpercent IS NULL
   OR availablequantity IS NULL
   OR weightInGms IS NULL
   OR outofstock IS NULL
   OR quantity IS NULL;
```

### 4. Find unique product categories

``` sql
SELECT DISTINCT category
FROM zepto_
ORDER BY category;
```

### 5. Compare products in stock vs out of stock

``` sql
SELECT
    outofstock,
    COUNT(sku_id)
FROM zepto_
GROUP BY outofstock;
```

### 6. Find product names appearing multiple times

``` sql
SELECT
    name,
    COUNT(sku_id) AS total_count
FROM zepto_
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY total_count DESC;
```

### 7. Find products with zero price

``` sql
SELECT *
FROM zepto_
WHERE mrp = 0
   OR discountedsellingprice = 0;
```

### 8. Remove products with zero MRP

``` sql
DELETE FROM zepto_
WHERE mrp = 0;
```

### 9. Rename the selling-price column

``` sql
ALTER TABLE zepto_
RENAME COLUMN discountsellingprice TO discountedsellingprice;
```

### 10. Convert price from paise to rupees

``` sql
UPDATE zepto_
SET mrp = mrp / 100.0,
    discountedsellingprice = discountedsellingprice / 100.0;
```

------------------------------------------------------------------------

# 🔍 Business Questions & SQL Analysis

## Q1. What are the top 10 best-value products based on discount percentage?

### SQL Query

``` sql
SELECT DISTINCT
    name,
    mrp,
    discountpercent
FROM zepto_
ORDER BY discountpercent DESC
LIMIT 10;
```

### What this analysis does

Identifies the products offering the highest discount percentages.

------------------------------------------------------------------------

## Q2. What are the products with high MRP but are out of stock?

### SQL Query

``` sql
SELECT DISTINCT
    name,
    mrp
FROM zepto_
WHERE outofstock = TRUE
  AND mrp > 300
ORDER BY mrp DESC;
```

### What this analysis does

Identifies relatively expensive products that are currently unavailable.

------------------------------------------------------------------------

## Q3. What is the estimated revenue for each category?

### SQL Query

``` sql
SELECT
    category,
    SUM(discountedsellingprice * availablequantity) AS total_revenue
FROM zepto_
GROUP BY category
ORDER BY total_revenue DESC;
```

### What this analysis does

Estimates category-level revenue using discounted selling price and
available quantity.

------------------------------------------------------------------------

## Q4. Which products have an MRP greater than ₹500 and a discount below 10%?

### SQL Query

``` sql
SELECT DISTINCT
    name,
    mrp,
    discountpercent
FROM zepto_
WHERE mrp > 500
  AND discountpercent < 10
ORDER BY mrp DESC, discountpercent DESC;
```

### What this analysis does

Identifies high-MRP products that have relatively low discounts.

------------------------------------------------------------------------

## Q5. Which are the top 5 categories with the highest average discount percentage?

### SQL Query

``` sql
SELECT
    category,
    ROUND(AVG(discountpercent), 2) AS highest_discount
FROM zepto_
GROUP BY category
ORDER BY highest_discount DESC
LIMIT 5;
```

### What this analysis does

Compares categories based on their average discount percentage.

------------------------------------------------------------------------

## Q6. Which product has sold the most?

### SQL Query

``` sql
SELECT
    name,
    SUM(quantity) AS total_quantity_sold
FROM zepto_
GROUP BY name
ORDER BY total_quantity_sold DESC
LIMIT 1;
```

### What this analysis does

Identifies the product with the highest total quantity sold.

------------------------------------------------------------------------

## Q7. What is the price per gram for products weighing 100g or more?

### SQL Query

``` sql
SELECT DISTINCT
    name,
    weightInGms,
    discountedsellingprice,
    ROUND(discountedsellingprice / weightInGms, 2) AS price_per_gram
FROM zepto_
WHERE weightInGms >= 100
ORDER BY price_per_gram;
```

### What this analysis does

Calculates price per gram to compare product value based on weight.

**Formula:**

`Price per Gram = Discounted Selling Price / Weight in Grams`

------------------------------------------------------------------------

## Q8. How can products be classified into Low, Medium, and Bulk based on weight?

### SQL Query

``` sql
SELECT DISTINCT
    name,
    weightInGms,
    CASE
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category
FROM zepto_;
```

### What this analysis does

Uses `CASE WHEN` to classify products into three weight categories.

-   **Low:** less than 1000g
-   **Medium:** 1000g to less than 5000g
-   **Bulk:** 5000g or more

------------------------------------------------------------------------

## Q9. What is the total inventory weight per category?

### SQL Query

``` sql
SELECT
    category,
    SUM(weightInGms * availablequantity) AS total_inventory_weight
FROM zepto_
GROUP BY category
ORDER BY total_inventory_weight DESC;
```

### What this analysis does

Calculates the total inventory weight available in each product
category.

**Formula:**

`Total Inventory Weight = Product Weight × Available Quantity`

------------------------------------------------------------------------

## Q10. Which category has the lowest average available inventory?

### SQL Query

``` sql
SELECT
    category,
    ROUND(AVG(availablequantity), 2) AS avg_inventory
FROM zepto_
GROUP BY category
ORDER BY avg_inventory
LIMIT 1;
```

### What this analysis does

Identifies the category with the lowest average available quantity.

------------------------------------------------------------------------

## Q11. Which products have low discounts but high sales?

### SQL Query

``` sql
SELECT
    name,
    discountpercent,
    quantity
FROM zepto_
WHERE discountpercent < 10
ORDER BY quantity DESC
LIMIT 5;
```

### What this analysis does

Finds the top 5 products with less than 10% discount but relatively high
sales quantity.

------------------------------------------------------------------------

## Q12. Which category has the highest revenue but also the highest average discount?

### SQL Query

``` sql
WITH category_stats AS (
    SELECT
        category,
        SUM(discountedsellingprice * quantity) AS total_revenue,
        AVG(discountpercent) AS avg_discount
    FROM zepto_
    GROUP BY category
)
SELECT *
FROM category_stats
WHERE total_revenue = (
    SELECT MAX(total_revenue)
    FROM category_stats
)
OR avg_discount = (
    SELECT MAX(avg_discount)
    FROM category_stats
);
```

### Alternative Query

``` sql
SELECT
    category,
    ROUND(SUM(discountedsellingprice * quantity), 2) AS total_revenue,
    ROUND(AVG(discountpercent), 2) AS avg_discount
FROM zepto_
GROUP BY category
ORDER BY total_revenue DESC, avg_discount DESC
LIMIT 1;
```

### What this analysis does

Compares categories using both **revenue** and **average discount**,
demonstrating the use of CTEs, aggregate functions, and subqueries.

------------------------------------------------------------------------

# 🧠 SQL Concepts Demonstrated

This project demonstrates practical use of:

-   `SELECT`
-   `WHERE`
-   `DISTINCT`
-   `ORDER BY`
-   `GROUP BY`
-   `HAVING`
-   `LIMIT`
-   `COUNT()`
-   `SUM()`
-   `AVG()`
-   `ROUND()`
-   `CASE WHEN`
-   `ALTER TABLE`
-   `UPDATE`
-   `DELETE`
-   CTEs
-   Subqueries
-   Aggregate Functions
-   Mathematical Calculations
-   Data Cleaning
-   Data Filtering
-   Data Aggregation

------------------------------------------------------------------------

# 📈 Skills Demonstrated

-   SQL Data Analysis
-   PostgreSQL
-   Data Cleaning
-   Business Question Analysis
-   Product Performance Analysis
-   Revenue Analysis
-   Discount Analysis
-   Inventory Analysis
-   Data Aggregation
-   Analytical Thinking

------------------------------------------------------------------------

# 🎯 Project Objective

The main objective of this project is to demonstrate practical SQL and
data-analysis skills by transforming a raw product dataset into
meaningful business insights.

The project shows how SQL can be used to answer real-world questions
related to:

-   Product performance
-   Sales
-   Pricing
-   Discounts
-   Revenue
-   Inventory
-   Product value
-   Category performance

------------------------------------------------------------------------

# 👨‍💻 Author

**Prashant Yadav**

Aspiring Data Analyst

**Skills:** SQL \| PostgreSQL \| Excel \| Power BI




## 📁 Project Files

### `ZEPTO_basic project.sql`

Contains all SQL queries used for data cleaning and business analysis.

### `ZEPTO4_FINAL.csv`

Contains the Zepto product dataset used for the analysis.

---

## 🎯 Project Objective

The main objective of this project is to demonstrate practical SQL and data-analysis skills by solving real-world business questions using a product-level dataset.

---

## 👨‍💻 Author

**Prashant Yadav**

Aspiring Data Analyst

**Skills:** SQL | PostgreSQL | Excel | Power BI
