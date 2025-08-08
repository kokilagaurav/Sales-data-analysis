--SQL retail sales analysis -p1
CREATE DATABASE SQL_PROJECT_P2


--create table
DROP TABLE IF EXISTS retail_sales_tb;
CREATE TABLE retail_sales_tb 
        (
         transactions_id INT PRIMARY KEY,
		 sale_date DATE,
		 sale_time TIME,
		 customer_id INT,
		 gender	VARCHAR(15),
		 age INT,
		 category VARCHAR(15),
		 quantiy INT,
		 price_per_unit FLOAT,
		 cogs FLOAT,
		 total_sale FLOAT
       );

SELECT * FROM retail_sales_tb;

-- count of all the rows in data set
SELECT COUNT(*) FROM retail_sales_tb;

--checking null values in the data set for each column

SELECT * FROM retail_sales_tb
WHERE 
	transactions_id is NULL
	OR 
	sale_date is NULL
	OR
	customer_id is null
	or
	gender is null
	or 
	age is null
	or
	category is null
	or 
	quantiy is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null;

-- DELETING ALL THE ROWS WITH NULL VALUES
DELETE FROM retail_sales_tb
WHERE
		transactions_id is NULL
	OR 
	sale_date is NULL
	OR
	customer_id is null
	or
	gender is null
	or 
	age is null
	or
	category is null
	or 
	quantiy is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null;

--DATA EXPLORATION 

-- HOW MANY SALES WE HAVE 
SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales_tb;

-- HOW MANY CUSTOMERS WE HAVE
SELECT COUNT(DISTINCT(customer_id)) AS TOTAL_CUSTOMERS FROM retail_sales_tb;

--HOW MANY UNIQUE CATEGORY WE HAVE
SELECT COUNT(DISTINCT category) as total_unique_category FROM retail_sales_tb;

-- LIST OF DISTINCT CATEGORY WE HAVE
SELECT DISTINCT(category)  FROM retail_sales_tb;


--DATA ANALYSIS AND BUSINESS KEY PROBLEM AND ANSWER

-- SALES MADE ON '2022-11-05'
SELECT * from retail_sales_tb
WHERE sale_date = '2022-11-05';

--retrieve all the transaction where category is clothign and the quantity sold is more than 10 in the month of novemerber
SELECT *
FROM retail_sales_tb
WHERE category = 'Clothing'
	AND 
	sale_date BETWEEN '2022-11-01' AND '2022-11-30'
	AND quantiy >=3; 

--query to calculate all total sale for each category
SELECT DISTINCT CATEGORY FROM 	retail_sales_tb;

SELECT Category, sum(total_sale) AS net_sale, COUNT(*) AS total_oders
FROM retail_sales_tb
GROUP  BY 1;

-- FIND AGE OF CUSTOMER WHO PURCHASE ITEM FOR BEAUTY CATEGORY
SELECT ROUND(AVG(age),2) 
FROM retail_sales_tb
WHERE category = 'Beauty';

--QUERY TO FIND ALL THE TRANSACTION WHERE TOTAL SALE >1000;
SELECT * FROM retail_sales_tb
WHERE total_sale >1000;

--QUERY TO FIND TOTAL NUMBER OF TRANSACTION (TRANSACTION ID ) MADE BY EACH GENDER IN EACH CATEGORY
SELECT gender, category, COUNT(*) AS total_count
FROM retail_sales_tb
GROUP BY gender, category;

-- query to calculate average sale of each month find out best selling month of the year
SELECT * FROM 
	(SELECT 
		EXTRACT(YEAR FROM sale_date) as year,	
		EXTRACT(MONTH FROM sale_date) as month,
		AVG(total_sale) as total_sale,
		RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS RANK
	FROM retail_sales_tb
	GROUP BY 1,2
	ORDER BY 1,3)
WHERE RANK = 1;


-- top 5 customer based on highest total sale
SELECT customer_id, 
		sum(total_sale) as total_sale
FROM retail_sales_tb
GROUP BY 1
ORDER BY 1,2 DESC
LIMIT 5;


-- QUERY TO FIND NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEM FROM EACH CATEGORY
SELECT category, COUNT(DISTINCT customer_id)
FROM retail_sales_tb
GROUP BY category;