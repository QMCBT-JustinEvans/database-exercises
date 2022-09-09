USE farmers_market;

SELECT CONCAT(customer_first_name, ' ', customer_last_name) AS full_name
FROM customer
HAVING full_name LIKE 'Betty%';
-- HAVING is used after WHERE (SQL Order: FROM & JOIN, WHERE, GROUP BY, HAVING, SELECT, ORDER BY, LIMIT)

USE employees;

SELECT SUBSTR(dept_no, 4, 1)
-- SUBSTR(string, start_index, length)
-- length can be left open by leaving argument blank
FROM departments;

SELECT CONCAT(UPPER(last_name), ', ', LOWER(first_name))
FROM employees
LIMIT 20;

SELECT REPLACE(dept_no, 'd00', 'Department ') AS Department
-- REPLACE(subject, search, replacement)
FROM departments;

SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();

USE farmers_market;

SELECT MAX(quantity)
FROM customer_purchases;

SELECT MIN(quantity)
FROM customer_purchases;

SELECT AVG(quantity)
FROM customer_purchases;

-- CASTING
SELECT 1 + 1;
SELECT 1 + '1';

