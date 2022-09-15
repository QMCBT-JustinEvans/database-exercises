-- 1. Using the example from the lesson, 
-- create a temporary table called employees_with_departments 
-- that contains first_name, last_name, and dept_name for employees currently with that department. 
-- Be absolutely sure to create this table on your own database. 
-- If you see "Access denied for user ...", 
-- it means that the query was attempting to write a new table to a database that you can only read.
USE mirzakhani_1942;

DROP TABLE IF EXISTS employees_with_departments; -- Use this to refresh
CREATE TEMPORARY TABLE employees_with_departments AS(
SELECT first_name, last_name, dept_name
FROM employees.employees
JOIN employees.dept_emp
ON employees.dept_emp.emp_no = employees.employees.emp_no
	AND employees.dept_emp.to_date LIKE '9999%'
JOIN employees.departments
ON employees.dept_emp.dept_no = employees.departments.dept_no);

SELECT *
FROM employees_with_departments;

-- a. Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is "long enough to encorporate" 
-- the sum of the lengths of the first name and last name columns

ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

SELECT *
FROM employees_with_departments;

-- b. Update the table so that full name column contains the correct data

UPDATE employees_with_departments SET full_name = CONCAT(first_name, ' ', last_name);

SELECT *
FROM employees_with_departments;
 
-- c. Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name, 
										DROP COLUMN last_name;

SELECT *
FROM employees_with_departments;

-- d. What is another way you could have ended up with this same table?

-- ANSWER: By changing the SELECT statement during creation
-- SELECT dept_name, CONCAT(first_name, ' ', last_name) AS full_name

-- 2. Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column 
-- such that it is stored as an integer representing the number of cents of the payment. 
-- For example, 1.99 should become 199.

SELECT *
FROM sakila.payment;

CREATE TEMPORARY TABLE sakila_payment_cents AS(
SELECT *
FROM sakila.payment);

SELECT *
FROM sakila_payment_cents;

-- ALTER TABLE sakila_payment_cents ADD cents DECIMAL;
-- UPDATE sakila_payment_cents SET cents = (amount * 100);
UPDATE sakila_payment_cents SET amount = amount * 100;

SELECT *
FROM sakila_payment_cents;

-- 4. FORMAT: Department Name, Current AVG, Historic AVG, STD Deviation, Z Score

CREATE TEMPORARY TABLE overall_aggregation AS(

SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
FROM employees.salaries
WHERE to_date LIKE '9999%'

);

SELECT *
FROM overall_aggregation;

DROP TABLE IF EXISTS current_info;
CREATE TEMPORARY TABLE current_info AS(

SELECT dept_name, AVG(salary) AS department_current_average
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.dept_emp.to_date LIKE '9999%'
	AND employees.salaries.to_date LIKE '9999%'
GROUP BY dept_name

);

SELECT *
FROM current_info;

ALTER TABLE current_info ADD overall_average FLOAT(10, 2);
ALTER TABLE current_info ADD overall_std FLOAT(10, 2);
ALTER TABLE current_info ADD z_score FLOAT(10, 2);

SELECT *
FROM current_info;

UPDATE current_info SET overall_average = (SELECT avg_salary FROM overall_aggregation);
UPDATE current_info SET overall_std = (SELECT std_salary FROM overall_aggregation);
UPDATE current_info SET z_score = (department_current_average - overall_average) / overall_std;

SELECT *
FROM current_info;