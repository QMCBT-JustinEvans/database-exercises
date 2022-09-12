-- GROUP BY
USE employees;

SELECT DISTINCT first_name
FROM employees;

SELECT first_name, COUNT(first_name) AS count_of_name
FROM employees
GROUP BY first_name
HAVING count_of_name > 270
ORDER BY count_of_name DESC;

SELECT COUNT(first_name)
FROM employees
WHERE first_name NOT LIKE '%A%';



