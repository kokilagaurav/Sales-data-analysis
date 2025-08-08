# Sales Data Analysis

This project analyzes retail sales data to extract business insights using SQL.

## Dataset

- **File:** `SQL - Retail Sales Analysis_utf .csv`
- **Columns:**
  - `transactions_id`: Unique transaction identifier
  - `sale_date`: Date of sale
  - `sale_time`: Time of sale
  - `customer_id`: Unique customer identifier
  - `gender`: Gender of the customer
  - `age`: Age of the customer
  - `category`: Product category (e.g., Clothing, Beauty, Electronics)
  - `quantiy`: Number of units sold
  - `price_per_unit`: Price per unit
  - `cogs`: Cost of goods sold
  - `total_sale`: Total sale amount

## SQL Analysis

- **File:** `retail_sales_analysis.sql`
- Use this file to write and execute SQL queries for analyzing the sales data.

## Usage

1. Import the CSV file into your preferred SQL database.
2. Use the queries in `retail_sales_analysis.sql` to perform analysis such as:
   - Sales trends over time
   - Category-wise sales performance
   - Customer demographics analysis
   - Profitability and cost analysis

## Requirements

- SQL database (e.g., MySQL, PostgreSQL, SQLite)
- SQL client or interface to run queries

## Notes

- Some rows may have missing values; handle them as needed during analysis.
- The dataset covers multiple years and includes various product categories.

## Questions, Answers, and SQL Queries

Below are the key business questions addressed in this project, along with the SQL queries used and example answers:

1. **How many rows are in the dataset?**
   - **Query:**  
     ```sql
     SELECT COUNT(*) FROM retail_sales_tb;
  

2. **Are there any rows with NULL values?**
   - **Query:**  
     ```sql
     SELECT * FROM retail_sales_tb
     WHERE transactions_id IS NULL
        OR sale_date IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
     ```


3. **How many sales do we have?**
   - **Query:**  
     ```sql
     SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales_tb;
     ```


4. **How many unique customers do we have?**
   - **Query:**  
     ```sql
     SELECT COUNT(DISTINCT(customer_id)) AS TOTAL_CUSTOMERS FROM retail_sales_tb;
     ```


5. **How many unique categories are there?**
   - **Query:**  
     ```sql
     SELECT COUNT(DISTINCT category) as total_unique_category FROM retail_sales_tb;
     ```


6. **List of distinct categories:**
   - **Query:**  
     ```sql
     SELECT DISTINCT(category) FROM retail_sales_tb;
     ```


7. **Sales made on '2022-11-05':**
   - **Query:**  
     ```sql
     SELECT * FROM retail_sales_tb WHERE sale_date = '2022-11-05';
     ```


8. **Transactions where category is Clothing and quantity sold is more than 10 in November:**
   - **Query:**  
     ```sql
     SELECT * FROM retail_sales_tb
     WHERE category = 'Clothing'
       AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
       AND quantiy >= 3;
     ```


9. **Total sale for each category:**
   - **Query:**  
     ```sql
     SELECT Category, SUM(total_sale) AS net_sale, COUNT(*) AS total_orders
     FROM retail_sales_tb
     GROUP BY 1;
     ```


10. **Average age of customers who purchased Beauty category items:**
    - **Query:**  
      ```sql
      SELECT ROUND(AVG(age),2)
      FROM retail_sales_tb
      WHERE category = 'Beauty';
      ```
 

11. **Transactions where total sale > 1000:**
    - **Query:**  
      ```sql
      SELECT * FROM retail_sales_tb WHERE total_sale > 1000;
      ```
 

12. **Total number of transactions by each gender in each category:**
    - **Query:**  
      ```sql
      SELECT gender, category, COUNT(*) AS total_count
      FROM retail_sales_tb
      GROUP BY gender, category;
      ```


13. **Best selling month of the year (average sale per month):**
    - **Query:**  
      ```sql
      SELECT * FROM (
        SELECT
          EXTRACT(YEAR FROM sale_date) as year,
          EXTRACT(MONTH FROM sale_date) as month,
          AVG(total_sale) as total_sale,
          RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS RANK
        FROM retail_sales_tb
        GROUP BY 1,2
        ORDER BY 1,3
      )
      WHERE RANK = 1;
      ```


14. **Top 5 customers based on highest total sale:**
    - **Query:**  
      ```sql
      SELECT customer_id, SUM(total_sale) as total_sale
      FROM retail_sales_tb
      GROUP BY 1
      ORDER BY 1,2 DESC
      LIMIT 5;
      ```

15. **Number of unique customers who purchased from each category:**
    - **Query:**  
      ```sql
      SELECT category, COUNT(DISTINCT customer_id)
      FROM retail_sales_tb
      GROUP BY category;
      ```

## Conclusion

This project demonstrates how SQL can be used to perform comprehensive analysis on retail sales data. By exploring sales trends, customer demographics, and category performance, valuable business insights can be extracted to inform decision-making and strategy. The approach outlined here can be adapted to similar datasets for further analysis and reporting.


