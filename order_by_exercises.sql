-- 1. Create a new file named order_by_exercises.sql 
-- and copy in the contents of your exercise from the previous lesson.

-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
-- and order your results returned by first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?

-- Answer: 1st = 'Irena Reutenauer'
-- 		   last = 'Vidya Simmen'
USE employees;

SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC;

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
-- and order your results returned by first name and then last name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?

-- Answer: 1st = 'Irena Acton'
-- 		   last = 'Vidya Zweizig'
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC, last_name ASC;

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
-- and order your results returned by last name and then first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?

-- Answer: 1st = 'Irena Acton'
-- 		   last = 'Maya Zyda'
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name ASC, first_name ASC;

-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their employee number. 
-- Enter a comment with the number of employees returned, the first employee number 
-- and their first and last name, and the last employee number with their first and last name.

-- Answer: 899 row(s) returned
-- 			1st = 10021 'Ramzi Erde'
--         last = 499648 'Tadahiro Erde'
SELECT first_name, last_name, emp_no 
FROM employees 
WHERE last_name LIKE 'E%E'
ORDER BY emp_no ASC;

-- 6. Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Sort the results by their hire date, so that the newest employees are listed first. 
-- Enter a comment with the number of employees returned, the name of the newest employee, 
-- and the name of the oldest employee.

-- Answer: 899 row(s) returned
-- 			Newest = 'Teiji Eldridge' (1999-11-27)
-- 			Oldest = 'Sergi Erde' (1985-02-02)
SELECT first_name, last_name, hire_date 
FROM employees 
WHERE last_name LIKE 'E%E'
ORDER BY hire_date DESC;

-- 7. Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, 
-- the name of the oldest employee who was hired last, 
-- and the name of the youngest employee who was hired first.

-- Answer: 362 row(s) returned
-- 			Oldest Last Hire = 'Khun Bernini'
-- 			Youngest First Hire = 'Douadi Pettis'
SELECT first_name, last_name, hire_date, birth_date
FROM employees 
WHERE hire_date LIKE '199%'
AND birth_date LIKE '%12-25'
ORDER BY birth_date ASC, hire_date DESC;