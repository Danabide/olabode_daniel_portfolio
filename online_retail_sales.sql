--Checking the data --1 million rows detected 
SELECT *
FROM online_retail_sales;

--Checking for duplicates -- No duplicate found
SELECT DISTINCT *
FROM online_retail_sales;

--Checking for Nulls
SELECT *
FROM online_retail_sales
WHERE transaction_id IS NULL   	OR timestamp IS NULL   		  OR customer_id IS NULL
	  OR product_id IS NULL    		OR product_category IS NULL	  OR price IS NULL
	  OR quantity IS NULL      		OR discount IS NULL			  OR customer_age IS NULL
	  OR customer_location IS NULL	OR customer_gender IS NULL	  OR total_amount IS NULL
	  OR payment_method IS NULL;
	  
--Checking for Inconsistency in Ids
SELECT *
FROM online_retail_sales
WHERE LENGTH(customer_id::text) <> 4;

SELECT *
FROM online_retail_sales
WHERE LENGTH(product_id::text) <> 3;

--Let's create a column that would store the age range 
ALTER TABLE online_retail_sales
ADD COLUMN customer_age_range text;

UPDATE online_retail_sales 
SET customer_age_range =
		CASE
			WHEN customer_age < 18 THEN 'Under 18'
			WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
			WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
			WHEN customer_age BETWEEN 36 AND 45 THEN '36-45'
			WHEN customer_age BETWEEN 46 AND 55 THEN '46-55'
			WHEN customer_age BETWEEN 56 AND 65 THEN '56-65'
			WHEN customer_age > 6 THEN 'Above 65'
			ELSE 'Unknown'
			END;

--Let's add a new column where we will Extract MONTH from Timestamp
ALTER TABLE online_retail_sales
ADD COLUMN order_year text,
ADD COLUMN order_month text,
ADD COLUMN order_week INTEGER,
ADD COLUMN order_day text;

UPDATE online_retail_sales 
SET order_year = EXTRACT(YEAR FROM timestamp),
	order_month = TO_CHAR(timestamp, 'Month'),
	order_week = EXTRACT(WEEK from timestamp),
	order_day = TO_CHAR(timestamp, 'Day');

--Let's Create a column that will store time_of_day 
ALTER TABLE online_retail_sales
ADD COLUMN time_of_day text;

UPDATE online_retail_sales
SET time_of_day =
			CASE 
				WHEN EXTRACT(HOUR FROM timestamp) BETWEEN 6 AND 11 THEN 'Morning'
				WHEN EXTRACT(HOUR FROM timestamp) BETWEEN 12 AND 17 THEN 'Afternoon'
				WHEN EXTRACT(HOUR FROM timestamp) BETWEEN 18 AND 21 THEN 'Evening'
				ELSE 'Night'
				END;

--Let's see how customers ordered and the total amount of money spent per year
SELECT customer_id, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_qty,
	   SUM(total_amount) AS total_amount_spent
FROM online_retail_sales
WHERE order_year = '2024'
GROUP BY customer_id
ORDER BY no_of_purchases DESC, total_qty DESC, total_amount_spent DESC
LIMIT 5;
--Note customers 1583, 4560, 1053, 1236, 3489

SELECT customer_id, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_qty,
	   SUM(total_amount) AS total_amount_spent
FROM online_retail_sales
WHERE order_year = '2023'
GROUP BY customer_id
ORDER BY no_of_purchases DESC, total_qty DESC, total_amount_spent DESC
LIMIT 5;
--Note Customers 4157, 2683, 1170, 4944, 3612

SELECT customer_id, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_qty,
	   SUM(total_amount) AS total_amount_spent
FROM online_retail_sales
WHERE order_year = '2024' AND customer_id IN ('4157', '2683', '1170', '4944', '3612')
GROUP BY customer_id
ORDER BY no_of_purchases DESC, total_qty DESC, total_amount_spent DESC;

--Let's discover the Product category that is mostly bought
SELECT ors.product_category, COUNT(*) AS no_of_orders, SUM(quantity) AS total_quantity, 
	   SUM(total_amount) AS total_amount, AVG(discount) AS avg_discount,
	   (SELECT product_id
	   	FROM online_retail_sales AS sub_ors
		WHERE ors.product_category = sub_ors.product_categorY
		GROUP BY product_id
	    ORDER BY COUNT(product_id) DESC
	   	LIMIT 1) AS most_bought_product
FROM online_retail_sales AS ors
GROUP BY ors.product_category
ORDER BY no_of_orders DESC, total_quantity DESC;

--Let's get the product category each age range buys most and of course the sum of the 
--prices they buy MOST and also the number of quantities they buy
SELECT ors.customer_age_range, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent,
		(SELECT product_category
		FROM online_retail_sales AS sub_ors
		WHERE ors.customer_age_range = sub_ors.customer_age_range
		GROUP BY product_category
		ORDER BY COUNT(*) DESC
		LIMIT 1) AS most_bought_product_category
FROM online_retail_sales AS ors
GROUP BY ors.customer_age_range
ORDER BY no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

--Let's also see the most bought products by Gender 
SELECT ors.customer_gender, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent,
		(SELECT product_category
		FROM online_retail_sales AS sub_ors
		WHERE ors.customer_gender = sub_ors.customer_gender
		GROUP BY product_category
		ORDER BY COUNT(*) DESC
		LIMIT 1) AS most_bought_product_category
FROM online_retail_sales AS ors
GROUP BY ors.customer_gender
ORDER BY no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

--	Also by location
SELECT ors.customer_location, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent,
		(SELECT product_category
		FROM online_retail_sales AS sub_ors
		WHERE ors.customer_location = sub_ors.customer_location
		GROUP BY product_category
		ORDER BY COUNT(*) DESC
		LIMIT 1) AS most_bought_product_category
FROM online_retail_sales AS ors
GROUP BY ors.customer_location
ORDER BY no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

SELECT customer_location, order_year, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent
FROM online_retail_sales
GROUP BY order_year, customer_location
ORDER BY order_year ASC, no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

--Knowing the Year that most orders arrive 
SELECT order_year, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_qty, 
	   SUM(total_amount) AS total_amount_spent
FROM online_retail_sales
GROUP BY order_year
ORDER BY order_year, no_of_purchases DESC, total_amount_spent DESC, total_qty DESC;

--Knowing the Month that most orders arrive 
SELECT ors.order_month, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent,
		(SELECT product_category
		FROM online_retail_sales AS sub_ors
		WHERE ors.order_month = sub_ors.order_month
		GROUP BY product_category
		ORDER BY COUNT(*) DESC
		LIMIT 1) AS most_bought_product_category
FROM online_retail_sales AS ors
GROUP BY ors.order_month
ORDER BY no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

SELECT order_year, order_month, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent
FROM online_retail_sales
GROUP BY order_year, order_month
ORDER BY order_year, no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

--What about for week?
SELECT order_week, COUNT(*) AS no_of_purchases, 
		SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent
FROM online_retail_sales
GROUP BY order_week
ORDER BY no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

What about for day?
SELECT order_year, order_day, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_realised
FROM online_retail_sales
GROUP BY order_year, order_day
ORDER BY order_year, no_of_purchases DESC, total_amount_realised DESC, total_quantity DESC;

--Let'S check for time of the day 
SELECT time_of_day, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent,
		(SELECT product_category
		FROM online_retail_sales AS sub_ors
		WHERE ors.time_of_day = sub_ors.time_of_day
		GROUP BY product_category
		ORDER BY COUNT(*) DESC
		LIMIT 1) AS most_bought_product_category
FROM online_retail_sales AS ors
GROUP BY ors.time_of_day
ORDER BY no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

SELECT time_of_day, order_year, COUNT(*) AS no_of_purchases, SUM(quantity) AS total_quantity,
	    SUM(total_amount) AS total_amount_spent
FROM online_retail_sales AS ors
GROUP BY order_year, time_of_day
ORDER BY order_year, no_of_purchases DESC, total_amount_spent DESC, total_quantity DESC;

--Let's check for preferred payment method by customers
SELECT payment_method, COUNT(*) AS method_count 
FROM online_retail_sales 
GROUP BY payment_method
ORDER BY COUNT(*) DESC;

--Let's for the product ids that are mostly bought by customers under every Product category
SELECT product_category, product_id, SUM(quantity) AS total_qty, COUNT(*) AS no_of_orders, 
	   AVG(discount) as avg_discount
FROM online_retail_sales
WHERE product_category = 'Books'
GROUP BY product_category, product_id
ORDER BY total_qty DESC, COUNT(*) DESC 
LIMIT 5;

--For Electronics
SELECT product_category, product_id, SUM(quantity) AS total_qty, COUNT(*) AS no_of_orders, 
	   AVG(discount) as avg_discount
FROM online_retail_sales
WHERE product_category = 'Electronics'
GROUP BY product_category, product_id
ORDER BY total_qty DESC, COUNT(*) DESC 
LIMIT 5;

--For Beauty & Personal Care
SELECT product_category, product_id, SUM(quantity) AS total_qty, COUNT(*) AS no_of_orders, 
	   AVG(discount) as avg_discount
FROM online_retail_sales
WHERE product_category = 'Beauty & Personal Care'
GROUP BY product_category, product_id
ORDER BY total_qty DESC, COUNT(*) DESC 
LIMIT 5;

--For Clothing 
SELECT product_category, product_id, SUM(quantity) AS total_qty, COUNT(*) AS no_of_orders, 
	   AVG(discount) as avg_discount
FROM online_retail_sales
WHERE product_category = 'Clothing'
GROUP BY product_category, product_id
ORDER BY total_qty DESC, COUNT(*) DESC 
LIMIT 5;

-- For Home & Kitchen
SELECT product_category, product_id, SUM(quantity) AS total_qty, COUNT(*) AS no_of_orders, 
	   AVG(discount) as avg_discount
FROM online_retail_sales
WHERE product_category = 'Home & Kitchen'
GROUP BY product_category, product_id
ORDER BY total_qty DESC, COUNT(*) DESC 
LIMIT 5;

--Sports & Outdoors
SELECT product_category, product_id, SUM(quantity) AS total_qty, COUNT(*) AS no_of_orders, 
	   AVG(discount) as avg_discount
FROM online_retail_sales
WHERE product_category = 'Sports & Outdoors'
GROUP BY product_category, product_id
ORDER BY total_qty DESC, COUNT(*) DESC 
LIMIT 5;

--Check for Churn in Customers 
SELECT customer_id, COUNT(*) AS no_of_transactions
FROM online_retail_sales
GROUP BY customer_id
ORDER BY no_of_transactions;

   
