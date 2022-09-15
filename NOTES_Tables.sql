USE mirzakhani_1942;

CREATE TEMPORARY TABLE my_numbers(
	n INT UNSIGNED NOT NULL);
    
SELECT *
FROM my_numbers;

INSERT INTO my_numbers(n) VALUES (1), (2), (3), (4), (5); 

UPDATE my_numbers SET n = n +1;
-- NOTE: CHANGE SETTINGS IN PREFERENCES
-- Error Code: 1064. 
-- You have an error in your SQL syntax; 
-- check the manual that corresponds to your MySQL server version 
-- for the right syntax to use near '+ 1' at line 1

DELETE FROM my_numbers WHERE n % 2 = 0;

CREATE TEMPORARY TABLE employees_with_departments AS (
SELECT employees.employees.emp_no, first_name, last_name, employees.departments.dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp
ON employees.dept_emp.emp_no = employees.employees.emp_no
JOIN employees.departments
ON employees.dept_emp.dept_no = employees.departments.dept_no
LIMIT 100);

SELECT *
FROM employees_with_departments;

ALTER TABLE employees_with_departments DROP COLUMN dept_no;

ALTER TABLE employees_with_departments ADD email VARCHAR(100);
UPDATE employees_with_departments SET email = CONCAT(first_name, '.', last_name, '@company.com');

-- CRUD = Creat, Read, Update, Delete
