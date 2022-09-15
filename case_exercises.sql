/* 1. Write a query that returns all employees, 
their department number, 
their start date, 
their end date, 
and a new column 'is_current_employee' 
that is a 1 if the employee is still with the company and 0 if not.*/
USE employees;

SELECT dept_no, from_date, to_date,
	IF (dept_emp.to_date LIKE '9999%', 1, 0 
	) AS is_current_employee
FROM dept_emp
JOIN employees
USING (emp_no);

/* 2. Write a query that returns all employee names (previous and current), 
and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
depending on the first letter of their last name.*/

SELECT first_name, last_name,
	IF (SUBSTRING(last_name, 1, 1) <= 'H', 
    'A-H', -- TRUE 
		IF (SUBSTRING(last_name, 1, 1) >= 'I' OR SUBSTRING(last_name, 1, 1) <= 'Q', 
			'I-Q', -- TRUE
			IF (SUBSTRING(last_name, 1, 1) >= 'R' OR SUBSTRING(last_name, 1, 1) <= 'Z', 
				'R-Z', -- TRUE
                NULL
    ))) AS alpha_group
FROM employees;

/* 3. How many employees (current or previous) were born in each decade?
ANSWER: I could have created temp tbl and used substr to pull decade from year 
but I wanted to utelize CASE Statements for the exercise */

SELECT 
	COUNT(CASE WHEN birth_date LIKE '195%' AND birth_date NOT LIKE '196%' THEN "50's" END) AS "50's",
    COUNT(CASE WHEN birth_date LIKE '196%' AND birth_date NOT LIKE '197%' THEN "60's" END) AS "60's",
    COUNT(CASE WHEN birth_date LIKE '197%' AND birth_date NOT LIKE '198%' THEN "70's" END) AS "70's",
    COUNT(CASE WHEN birth_date LIKE '198%' AND birth_date NOT LIKE '199%' THEN "80's" END) AS "80's",
    COUNT(CASE WHEN birth_date LIKE '199%' AND birth_date NOT LIKE '2000%' THEN "90's" END) AS "90's",
    COUNT(CASE WHEN birth_date LIKE '2000%' AND birth_date NOT LIKE '2010%' THEN "2000's" END) AS "2000's",
    COUNT(CASE WHEN birth_date LIKE '2010%' AND birth_date NOT LIKE '2020%' THEN "2010's" END) AS "2010's"
FROM employees
ORDER BY birth_date;

/* 4. What is the current average salary for each of the following department groups: 
R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
*/
SELECT *
FROM dept_emp

