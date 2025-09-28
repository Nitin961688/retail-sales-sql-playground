--TABLE VIEW
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM purchases;

-- BASIC QUERY
--Get customer names and their cities
SELECT 	
	CONCAT(first_name,' ', last_name) as full_name, city 
FROM customers;

--List unique product categories
SELECT 
	DISTINCT category 
FROM products;

--Find purchases above 100
SELECT 
* FROM purchases 
	WHERE total_amount>100;

--Sort customers by gender
SELECT 	
	CONCAT(first_name,' ', last_name) as full_name, gender
FROM customers;

--INTERMINDATE QUERIES
--Total revenue generated
SELECT 
	ROUND(SUM(total_amount),2) AS TOTAL_AMOUNT 
FROM purchases;

--Average revenue per purchase
SELECT 
	ROUND(AVG(total_amount),2) AS AVG_AMOUNT 
FROM purchases;

--Revenue per product
SELECT
	pr.product_name, SUM(quantity*price_per_unit) AS total_revenve 
FROM purchases p 
	JOIN 
products pr 
	ON p.product_id =pr.product_id 
GROUP BY pr.product_name
ORDER BY total_revenve DESC;

--Revenue per customer
SELECT
	CONCAT(first_name,' ', last_name) AS FULL_NAME, SUM(quantity*price_per_unit) AS total_revenve 
FROM purchases p
	JOIN 
products pr 
	ON p.product_id =pr.product_id
	JOIN
customers c
	ON c.customer_id =p.customer_id 
GROUP BY FULL_NAME
ORDER BY total_revenve DESC;

-- Average revenue per user (ARPU)
SELECT 
ROUND(AVG(TOTAL_AMOUNT),2) AS AVERAGE_REVENUE_PER_USER
FROM( SELECT 
	customer_id, ROUND(SUM(total_amount),2) AS TOTAL_AMOUNT 
FROM purchases
GROUP BY customer_id);

-- Find top 5 customers by spending
SELECT
	CONCAT(first_name,' ', last_name) AS FULL_NAME, SUM(quantity*price_per_unit) AS total_spent 
FROM purchases p
	JOIN 
products pr 
	ON p.product_id =pr.product_id
	JOIN
customers c
	ON c.customer_id =p.customer_id 
GROUP BY FULL_NAME
ORDER BY total_spent DESC
limit 5;

--Number of purchases per customer
SELECT 
	customer_id, count(*) 
FROM purchases
GROUP BY customer_id
ORDER BY COUNT(*) DESC
LIMIT 10;

-- HAVING filters aggregated groups
SELECT customer_id, SUM(total_amount) as total_spent
FROM purchases
GROUP BY customer_id
HAVING SUM(total_amount) > 500;

--Create a view for customer spending
CREATE VIEW customer_spending AS
SELECT c.customer_id, CONCAT(first_name,' ', last_name) AS FULL_NAME, SUM(pr.total_amount) AS total_spent
FROM purchases pr
JOIN customers c ON pr.customer_id = c.customer_id
GROUP BY c.customer_id, FULL_NAME;
SELECT * FROM customer_spending LIMIT 10;

-- Optimize query with index
CREATE INDEX idx_customer_id ON purchases(customer_id);
CREATE INDEX idx_product_id ON purchases(product_id);

--Customers who never purchased anything
SELECT c.customer_id, CONCAT(first_name,' ', last_name) AS FULL_NAME
FROM customers c
LEFT JOIN purchases pr ON c.customer_id = pr.customer_id
WHERE pr.purchase_id IS NULL;


--Top product in each category
SELECT category, product_name, total_revenue
FROM (
    SELECT p.category, p.product_name, SUM(pr.total_amount) AS total_revenue,
           RANK() OVER (PARTITION BY p.category ORDER BY SUM(pr.total_amount) DESC) AS rnk
    FROM purchases pr
    JOIN products p ON pr.product_id = p.product_id
    GROUP BY p.category, p.product_name
) ranked
WHERE rnk = 1;

