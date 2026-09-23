# Store Sales SQL Analysis

## Project Overview

This project presents an end-to-end retail sales analysis using SQL Server.

The objective of the project is to explore the dataset, evaluate data quality, analyze sales and profitability performance, identify customer and product trends, measure growth over time, and generate business-focused insights using SQL.

The project progresses from basic database exploration to advanced analytical techniques including window functions, CTEs, ranking, customer segmentation, cumulative analysis, and year-over-year and month-over-month performance analysis.

---

## Tools Used

- SQL Server
- SQL Server Management Studio (SSMS)

---

## SQL Skills Applied

- select statements
- aggregate functions
- group by
- distinct
- order by
- case statements
- date functions
- datediff
- datetrunc
- common table expressions (CTEs)
- window functions
- rank()
- lag()
- ntile()
- running totals
- year-over-year analysis
- month-over-month analysis
- customer segmentation
- part-to-whole analysis

---

## Dataset

The dataset contains retail transaction information including:

- Order ID
- Customer ID
- Customer Name
- Product ID
- Product Name
- Category
- Sub-Category
- Segment
- Country
- Region
- State
- City
- Sales
- Profit
- Quantity
- Discount
- Order Date
- Ship Date
- Ship Mode

---

# Project Analysis

## 1. Database Exploration

The first stage focuses on understanding the structure and quality of the dataset.

The analysis includes:

- Exploring available columns
- Counting total rows
- Checking duplicate row IDs
- Checking missing values
- Checking invalid or negative values
- Reviewing potential sales outliers
- Validating order and shipping dates

---

## 2. Dimension Exploration

The main categorical dimensions were explored to understand how the data can be segmented.

Dimensions include:

- City
- State
- Region
- Country
- Segment
- Category
- Sub-Category
- Ship Mode

---

## 3. Date Range Exploration

The dataset was analyzed to identify:

- First order date
- Last order date
- Overall data time span
- Minimum shipping duration
- Maximum shipping duration
- Average shipping duration
- Distribution of orders by shipping days

---

## 4. Measures Exploration

High-level business KPIs were calculated including:

- Total Sales
- Total Profit
- Total Quantity Sold
- Total Orders
- Total Customers
- Total Products
- Average Profit

---

## 5. Magnitude Analysis

Business performance was analyzed across different dimensions.

The analysis includes:

- Sales by Segment
- Sales by Region
- Sales by State
- Sales by Category
- Sales by Sub-Category
- Profit by Dimension
- Quantity Sold by Dimension

---

## 6. Ranking Analysis

Ranking techniques were used to identify the strongest and weakest performers.

The analysis includes:

- Top 10 Products by Sales
- Top 10 Customers by Sales
- Top States by Sales
- Top States by Profit
- Bottom Products by Profit
- Category Sales Ranking
- Sub-Category Profit Ranking

The `rank()` window function was used to generate performance rankings.

---

## 7. Change Over Time Analysis

Sales performance was analyzed over time to identify trends.

The analysis includes:

- Yearly Sales
- Monthly Sales
- Monthly Profit
- Monthly Order Volume

---

## 8. Year-over-Year Growth

CTEs and the `lag()` window function were used to compare yearly sales with the previous year.

The analysis calculates:

- Current Year Sales
- Previous Year Sales
- Year-over-Year Growth Percentage

Formula:

YoY Growth (%) =  
(Current Year Sales - Previous Year Sales) / Previous Year Sales × 100

---

## 9. Month-over-Month Growth

Monthly sales were compared with the previous month using the `lag()` function.

The analysis calculates:

- Current Month Sales
- Previous Month Sales
- Sales Difference
- Month-over-Month Growth Percentage

Formula:

MoM Growth (%) =  
(Current Month Sales - Previous Month Sales) / Previous Month Sales × 100

---

## 10. Cumulative Analysis

Running totals were calculated to understand how business performance developed over time.

The analysis includes:

- Cumulative Sales
- Cumulative Profit

---

## 11. Performance Analysis

Product performance was compared against average product sales.

Products were classified as:

- Above Average
- Average
- Below Average

Products were also classified based on profitability:

- Profitable
- Loss Making
- Break Even

---

## 12. Part-to-Whole Analysis

The contribution of each business segment to overall performance was calculated.

The analysis includes:

- Percentage of Sales by Category
- Percentage of Sales by Segment
- Percentage of Profit by Region

---

## 13. Customer Segmentation

Customers were segmented into three groups using `ntile()` based on total sales:

- High Value Customers
- Medium Value Customers
- Low Value Customers

This approach creates data-driven customer segments rather than using arbitrary thresholds.

---

## 14. Customer Analysis

A detailed customer-level analysis was created including:

- Total Orders
- Total Sales
- Total Profit
- Average Order Value
- First Order Date
- Last Order Date
- Customer Lifetime
- Customer Sales Ranking

---

## 15. Product Analysis

Product-level performance was analyzed using:

- Total Sales
- Total Profit
- Quantity Sold
- Profit Margin
- Product Sales Ranking

---

## 16. Shipping Analysis

Shipping performance was analyzed based on delivery duration.

The analysis includes:

- Average Shipping Days by Ship Mode
- Minimum Shipping Days
- Maximum Shipping Days
- Number of Orders
- Average Shipping Days by Region

Orders were also segmented into:

- Fast Shipping
- Normal Shipping
- Slow Shipping

---

## 17. Discount Analysis

The relationship between discounts and business performance was explored.

The analysis compares:

- Discount Level
- Total Sales
- Total Profit
- Number of Orders

This analysis can help identify whether higher discounts are associated with stronger sales or lower profitability.

---

## 18. Final Customer Report

A final customer-level business report was developed containing:

- Customer ID
- Customer Name
- Total Orders
- Total Sales
- Total Profit
- Total Quantity
- Average Order Value
- First Order Date
- Last Order Date
- Customer Lifetime
- Sales Ranking

---

## Business Questions Answered

This project addresses questions such as:

- Which products generate the highest sales?
- Which customers contribute the most revenue?
- Which regions and states perform best?
- Which products generate losses?
- How are sales changing over time?
- What is the YoY growth rate?
- What is the MoM growth rate?
- Which categories contribute the most to total sales?
- Which customers should be considered high-value?
- How long does shipping typically take?
- Which shipping modes provide the fastest delivery?
- How do discounts affect sales and profitability?

---

## Project Structure

```text
store-sales-sql-analysis
│
├── retail_sales_analysis.sql
├── README.md
└── dataset
