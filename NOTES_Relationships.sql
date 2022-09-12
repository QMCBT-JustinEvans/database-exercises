-- JOINS

USE employees;

DESCRIBE departments;
SELECT * FROM departments;

DESCRIBE dept_emp;
SELECT * FROM dept_emp;
SHOW CREATE TABLE dept_emp;

/*dept_emp, CREATE TABLE `dept_emp` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_emp_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_emp_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1*/

DESCRIBE employees;
SELECT * FROM employees LIMIT 50;

SELECT * FROM dept_emp LIMIT 50;

-- Inner JOIN of employes and dept_emp
SELECT *
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
LIMIT 50;

-- Inner JOIN of employes, dept_emp, and departments
SELECT *
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
LIMIT 50;

-- Selecting column from Inner JOIN
SELECT employees.first_name, 
employees.last_name, 
departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
LIMIT 50;

-- USING ALIAS
SELECT e.first_name, 
		e.last_name, 
		d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
LIMIT 50;

-- Add WHERE clause
SELECT e.first_name, 
		e.last_name, 
		d.dept_name,
        e.gender
FROM employees AS e
JOIN dept_emp AS de 
ON e.emp_no = de.emp_no
JOIN departments AS d 
ON de.dept_no = d.dept_no
WHERE e.gender = 'F';

