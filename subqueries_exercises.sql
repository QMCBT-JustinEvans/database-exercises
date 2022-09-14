USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT *
FROM employees

JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
	AND to_date LIKE '9999%'

WHERE employees.hire_date = (SELECT hire_date
								FROM employees
								WHERE employees.emp_no = '101010'
								);

-- BUILD Queries seperately first
SELECT hire_date
FROM employees
WHERE employees.emp_no = '101010';

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT title AS Title, COUNT(titles.emp_no) AS Count
FROM titles

WHERE emp_no IN (SELECT employees.emp_no
				FROM employees

				JOIN dept_emp
				ON employees.emp_no = dept_emp.emp_no
					AND dept_emp.to_date LIKE '9999%'
					AND employees.first_name = 'Aamod')

GROUP BY title
ORDER BY title;

-- BUILD Queries seperately first
SELECT title, COUNT(employees.emp_no)
FROM employees

JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
	AND dept_emp.to_date LIKE '9999%'
	AND employees.first_name = 'Aamod'
    
LEFT JOIN titles
ON employees.emp_no = titles.emp_no

GROUP BY title;

-- Are there employees without departments that have titles?
-- ANSWER: No NULL for dept_no
SELECT emp_no, last_name, dept_no, dept_emp.to_date, title, titles.to_date
FROM employees

LEFT JOIN dept_emp
USING (emp_no)

LEFT JOIN titles
USING (emp_no);

-- 3. How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code.
-- ANSWER: 85,108
SELECT COUNT(emp_no)
FROM employees
WHERE emp_no IN (SELECT emp_no
					FROM dept_emp
					WHERE to_date NOT LIKE '9999%');

-- get emp_no of all not current employees
SELECT emp_no, to_date
FROM dept_emp
WHERE to_date NOT LIKE '9999%';

-- 4. Find all the current department managers that are female. 
-- List their names in a comment in your code.
-- ANSWER: 'Leon DasSarma', 
-- 			'Hilary Kambil', 
-- 			'Isamu Legleitner'
-- 			'Karsten Sigstam'

SELECT CONCAT(first_name, ' ', last_name) AS 'Manager Name'
FROM employees
WHERE emp_no in (SELECT emp_no
					FROM dept_manager
					WHERE to_date LIKE '9999%')
AND gender = 'F'
ORDER BY last_name;

-- 5. Find all the employees who currently have a higher salary 
-- than the companies overall, historical average salary.
SELECT COUNT(emp_no)
-- SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE emp_no IN(SELECT emp_no
				FROM salaries
				WHERE salary > (SELECT AVG(salary)
								FROM salaries)
						AND to_date LIKE '9999%')
ORDER BY last_name;

-- BUILD Queries seperately first
SELECT AVG(salary)
FROM salaries;

SELECT emp_no
FROM salaries
WHERE salary > (SELECT AVG(salary)
				FROM salaries)
 	AND to_date LIKE '9999%';

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- 		Hint: you can use a built in function to calculate the standard deviation.
-- What percentage of all salaries is this?
-- 		Hint You will likely use multiple subqueries in a variety of ways
-- 		Hint It's a good practice to write out all of the small queries that you can. 
-- 			Add a comment above the query showing the number of rows returned. 
-- 			You will use this number (or the query that produced it) in other, larger queries.

SELECT COUNT(*) 
FROM salaries
WHERE to_date > CURDATE() 
	AND salary >= ((SELECT MAX(salary)
		FROM salaries
		WHERE to_date LIKE '9999%'
		)-(SELECT STD(salary)
			FROM salaries
            WHERE to_date LIKE '9999%'));

-- TEST MAX - Deviation
SELECT * 
FROM salaries
WHERE salary >= ((SELECT MAX(salary)
		FROM salaries
		WHERE to_date LIKE '9999%'
		)-(SELECT STD(salary)
			FROM salaries
            WHERE to_date LIKE '9999%'));

-- Current Salary (240,124)
SELECT COUNT(*)
FROM salaries
WHERE to_date LIKE '9999%';

-- MAX Salary ($ 158,220.00)
SELECT max(salary)
FROM salaries
WHERE to_date LIKE '9999%';

-- Standard Deviation = STD(expression) (17,309.96)
SELECT STD(salary)
FROM salaries
WHERE to_date LIKE '9999%';