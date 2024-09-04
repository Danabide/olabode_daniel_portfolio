SELECT * 
FROM carsales;

SELECT DISTINCT salesperson
FROM carsales;

SELECT DISTINCT customer_name
FROM carsales;

SELECT *, EXTRACT (YEAR FROM date) AS sales_year
FROM carsales;

--DETERMINING THE HIGHEST SELLING SALESPERSON 
SELECT salesperson, COUNT(*) AS Number_of_sales
FROM carsales
GROUP BY salesperson
ORDER BY COUNT(*) DESC
LIMIT 10;

--DETERMINING THE HIGHEST BUYING CUSTOMER 
SELECT customer_name, COUNT(*) AS Number_of_purchases
FROM carsales
GROUP BY customer_name
ORDER BY COUNT(*) DESC
LIMIT 10;

--DETERMINING THE HIGHEST SELLING CAR MAKE
SELECT car_make, COUNT(*) AS car_make_occurences
FROM carsales
GROUP BY car_make
ORDER BY COUNT(*) DESC

--DETERMINING THE HIGHEST SELLING MODEL OF ALL
SELECT model, COUNT(*) AS no_of_sales
FROM carsales 
GROUP BY model
ORDER BY COUNT(*) DESC;

--DETERMINING THE HIGHEST SELLING MODEL BY EACH CAR MAKE
SELECT car_make, model, COUNT(model) AS modelcount
FROM carsales 
GROUP BY car_make, model
ORDER BY COUNT(model) DESC;

--DETERMINING THE PREVALENT YEAR OF CARS SOLD
SELECT car_year, COUNT(*) AS frequency_of_product_year
FROM carsales
GROUP BY car_year
ORDER BY COUNT(*) DESC;


ALTER TABLE carsales
ADD COLUMN sale_year INTEGER;

UPDATE carsales
SET sale_year = EXTRACT(YEAR FROM date);

ALTER TABLE carsales
ADD COLUMN product_year_to_sale INTEGER;

UPDATE carsales
SET product_year_to_sale = sale_year - car_year;

--DETERMINING THE CAR MAKE WITH THE HIGHEST SALES PRICE
SELECT car_make, SUM(sales_price) AS total_sp
FROM carsales
GROUP BY car_make
ORDER BY total_sp DESC;

--DETERMINING THE AVERAGE SELLING PRICE OF EACH CAR MODEL BY THEIR CAR MAKE
WITH avg_prices AS 
	(SELECT car_make, model, AVG(sales_price) AS avg_sp
	 FROM carsales
	 GROUP BY car_make, model)
	 
SELECT car_make, 
	   model, 
	   avg_sp,
	   ROW_NUMBER() OVER (PARTITION BY model ORDER BY avg_sp DESC) AS row_num
FROM avg_prices
ORDER BY model, row_num;

--DETERMINING THE YEAR THAT HAD SOLD MOST 
SELECT sale_year, COUNT(*) AS no_of_sales
FROM carsales
GROUP BY sale_year
ORDER BY no_of_sales DESC;

--DETERMINING THE YEAR WITH THE HIGHEST AVERAGE SALES PRICE
SELECT sale_year, AVG(sales_price) AS avg_salesprice
FROM carsales
GROUP BY sale_year
ORDER BY avg_salesprice DESC;

--DETERMINING HOW THE DURATION BETWEEN PRODUCTION AFFECTS PRICE
SELECT product_year_to_sale, AVG(sales_price) AS avg_sp
FROM carsales
GROUP BY product_year_to_sale
ORDER BY avg_sp DESC;
	 
--DETERMINING THE SALESPERSON THAT EARNED THE HIGHEST COMMISSION
SELECT salesperson, ROUND(SUM(commission_earned::NUMERIC), 2) AS total_commission_earned
FROM carsales
GROUP BY salesperson
ORDER BY total_commission_earned DESC
LIMIT 10;

--DETERMINING THE AVERAGE COMMISSION EARNED BY CAR MAKES
SELECT car_make, ROUND(AVG(commission_earned::NUMERIC), 2) AS avg_ce
FROM carsales
GROUP BY car_make
ORDER BY avg_ce DESC;


--DETERMINING THE AVERAGE COMMISSION BY EACH MODEL OF EACH CAR MAKE
SELECT car_make, model, ROUND(AVG(commission_earned::NUMERIC), 2) AS avg_ces
FROM carsales
GROUP BY car_make, model 
ORDER BY avg_ces DESC;

--DETERMINING THE MOST PURCHASED CAR MODEL IN RELATIVE TO THEIR 
SELECT model, COUNT(*)
FROM carsales
GROUP BY model
ORDER BY COUNT(*) DESC;

--DETERMINING THE AVERAGE SALE PRICE OF CARS BY THEIR CAR_MAKE TO KNOW MOST EXPENSIVE
SELECT car_make, ROUND(AVG(Sales_price), 2) AS avg_sales_price
FROM carsales
GROUP BY car_make
ORDER BY avg_sales_price DESC;

--DETERMINING THE AVG SALE PRICE CARS BY CAR_MAKE AND MODEL TO KNOW MOST EXPENSIVE
SELECT car_make, model, ROUND(AVG(Sales_price), 2) AS avg_sales_price
FROM carsales
GROUP BY car_make,model
ORDER BY car_make, avg_sales_price DESC;

--DETERMINING TOP 10 OF SALES PRICE, CAR MAKE, MODEL, CAR YEAR AND SALE YEAR
SELECT sales_price, car_make, model, car_year, sale_year
FROM carsales
ORDER BY sales_price DESC
LIMIT 100;

--DETERMINING THE HIGHEST NO OF CAR MAKES THAT HAVE THE HIGHEST SALE PRICES
SELECT car_make, COUNT(*) AS car_makecount
FROM carsales
WHERE sales_price = '50000'
GROUP BY car_make
ORDER BY COUNT(*) DESC;

--DETERMINING THE HIGHEST NO OF CAR MODELS THAT HAVE THE HIGHEST SALE PRICES
SELECT model, COUNT(*) AS modelcount
FROM carsales
WHERE sales_price = '50000'
GROUP BY model
ORDER BY COUNT(*) DESC;


ALTER TABLE carsales
ADD COLUMN sale_monthname VARCHAR(20);

UPDATE carsales
SET sale_monthname = TO_CHAR(date, 'Month');
--DETECTING WHICH MONTH HAD THE HIGHEST SALES
SELECT sale_year, sale_monthname, COUNT(*) AS no_of_sales
FROM carsales
GROUP BY sale_year, sale_monthname
ORDER BY sale_year, COUNT(*) DESC;

--CARS MAKE THAT SOLD MOST IN DIFFERENT YEARS
SELECT car_make, sale_year, COUNT(*) AS no_of_sales
FROM carsales
GROUP BY car_make, sale_year
ORDER BY sale_year, COUNT(*) DESC;

--CAR MODEL THAT SOLD MOST IN DIFFRENT YEARS
SELECT model, sale_year, COUNT(*) AS no_of_sales
FROM carsales
GROUP BY model, sale_year
ORDER BY sale_year, COUNT(*) DESC;

--DETERMINING THE car make, model & sales man which the highest commission rate, earned
SELECT  salesperson, car_make, model, sales_price, commission_rate, commission_earned
FROM carsales
ORDER BY commission_rate DESC, commission_earned DESC
LIMIT 10;

ALTER TABLE carsales
ADD COLUMN net_amount_earned NUMERIC;

UPDATE carsales
SET net_amount_earned = sales_price - commission_earned;

--DETERMINING SELLERS WHO HAD THE HIGHEST NET AMOUNT EARNED
SELECT salesperson, SUM(net_amount_earned)
FROM carsales
GROUP BY salesperson
ORDER BY SUM(net_amount_earned) DESC
LIMIT 10;

--DETERMINING TOP TEN CARS THAT GAVE SELLERS THE HIGHEST NEXT AMOUNT EARNED
SELECT salesperson, car_make, model, net_amount_earned
FROM carsales
ORDER BY net_amount_earned DESC
LIMIT 10;

--DETERMINING THE AVERAGE COMMISSION RATE BY CAR MAKE
SELECT car_make, AVG(commission_rate) AS avg_cr
FROM carsales
GROUP BY car_make
ORDER BY avg_cr DESC;

