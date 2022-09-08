-- WHERE
USE employees;

SELECT * FROM employees WHERE hire_date = '1993-11-19';

SELECT DISTINCT first_name FROM employees WHERE first_name LIKE 'sus%';

SELECT DISTINCT first_name FROM employees WHERE first_name BETWEEN 'A' AND 'D';
-- BETWEEN is inclusive on both sides with Numbers but exclusive on end with Letters

SELECT DISTINCT first_name FROM employees WHERE first_name BETWEEN 'AD' AND 'DF';

SELECT * FROM employees WHERE first_name IN ('Herbert', 'Zvonko');

SELECT * FROM zillow.properties_2016
WHERE basementsqft IS NOT NULL;

SELECT * FROM fruits_db.fruits WHERE id > 4 AND quantity > 5;

-- ORDER BY
USE farmers_market;

SELECT *
FROM customer_purchases
ORDER BY customer_id ASC, quantity DESC;

-- LIMIT
USE employees;

SELECT *
FROM employees
LIMIT 10 OFFSET 20;
-- OFFSET = skip

