-- --------------------Sales Insights using MySQL------------------------
-- ------------------------Basic Data Analysis---------------------------

-- explore tables, which type of data is stored
SELECT * FROM transactions;
/*this table contains negative value and inconsistent currency in couple of transactions, 
which either needs to remove or convert the currency*/

SELECT * FROM customers;
SELECT * FROM date;
SELECT * FROM markets;
-- markets table contains two cities out of india, which needs to be removed

SELECT * FROM products;

SELECT COUNT(*) FROM transactions;
-- transactions table is most important, it contains 150283 transactions


-- How many total customers are there
SELECT COUNT(*) FROM customers;		#38
-- ----------------------------------------------------------------------------------

-- Exploratory Data Analysis

SELECT * FROM transactions WHERE market_code="Mark001"; #Show transactions made in chennai


SELECT COUNT(*) FROM transactions WHERE market_code="Mark001"; # How many transactions are made in chennai

-- How many transactions are there with the currency USD?
SELECT * FROM transactions WHERE currency="USD";	#two transactions

-- Filter transactions based on particular year or month(e.g. i am interested in 2020)
SELECT transactions.*,date.* FROM transactions INNER JOIN date ON transactions.order_date=date.date
WHERE date.year=2020 AND date.month_name="January";


-- How many transactions were performed in Jan 2020
SELECT COUNT(*) transactions FROM transactions INNER JOIN date ON transactions.order_date=date.date
WHERE date.year=2020 AND date.month_name="January";		#4003


-- Show the total revenue of 2019
SELECT SUM(transactions.sales_amount) FROM transactions 
INNER JOIN date ON transactions.order_date=date.date
WHERE date.year=2019;		#336.452114 millions

-- Show the total revenue of 2020
SELECT SUM(transactions.sales_amount) FROM transactions 
INNER JOIN date ON transactions.order_date=date.date
WHERE date.year=2020;		#142.235559 millions


-- Show the revenue made in Chennai all the time
SELECT SUM(transactions.sales_amount) FROM transactions WHERE market_code="Mark001";		#18.227503 million

-- Show the revenue made in Chennai in 2020
SELECT SUM(transactions.sales_amount) FROM transactions 
INNER JOIN date ON transactions.order_date=date.date
WHERE date.year=2020 AND market_code="Mark001";			#2.463024 million

-- How many distinct products were sold in Chennai
SELECT DISTINCT product_code FROM transactions WHERE market_code="Mark001";


-- Find out the leading year by number of products sold in
SELECT SUM(sales_qty) AS items_sold_in_year, date.year FROM transactions 
INNER JOIN date ON transactions.order_date=date.date 
GROUP BY date.year ORDER BY items_sold_in_year DESC;		
#2018 is the leading year in which 1.002284 million) products were sold


-- How many total products are sold
SELECT SUM(sales_qty) FROM transactions;		#2.444415 million products

SELECT SUM(sales_amount) AS revenue_by_city, markets_name FROM transactions 
INNER JOIN markets ON transactions.market_code=markets.markets_code
GROUP BY markets.markets_name ORDER BY revenue_by_city DESC;		
#Delhi NCR is the leading market by revenue of 520.721134 million


SELECT SUM(sales_amount) FROM transactions;		#986.565766 million
