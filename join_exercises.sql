-- Join Example Database

-- 1. Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SELECT *
FROM users;
SELECT *
FROM roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables 
-- as we did in the lesson. Before you run each query, guess the expected number of results.

-- GUESS = 4 rows
SELECT *
FROM users
JOIN roles
ON users.role_id = roles.id;

-- GUESS = 6 rows
SELECT *
FROM users
LEFT JOIN roles
ON users.role_id = roles.id;

-- GUESS = 5 rows
SELECT *
FROM users
RIGHT JOIN roles
ON users.role_id = roles.id;

-- 3. Although not explicitly covered in the lesson, 
-- aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles 
-- along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.

SELECT roles.name, COUNT(users.name)
FROM users
RIGHT JOIN roles
ON users.role_id = roles.id
GROUP By roles.id;

-- Employees Database

-- 1. Use the employees database.
USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department.

--  Department Name    | Department Manager
-- --------------------+--------------------
--  Customer Service   | Yuchang Weedman
--  Development        | Leon DasSarma

SELECT departments.dept_name AS 'Department Name', 
	CONCAT(employees.first_name, 
	' ', 
    employees.last_name) AS 'Department Manager'
FROM departments
LEFT JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
-- 	AND dept_manager.to_date LIKE '9999%'
LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no
-- USING (emp_no)
WHERE dept_manager.to_date LIKE '9999%'
ORDER BY departments.dept_name;

-- 3. Find the name of all departments currently managed by women.

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

SELECT departments.dept_name AS 'Department Name', 
	CONCAT(employees.first_name, 
	' ', 
    employees.last_name) AS 'Manager Name'
FROM departments
LEFT JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no
LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no
WHERE dept_manager.to_date LIKE '9999%'
	AND employees.gender = 'F'
ORDER BY departments.dept_name;

-- 4. Find the current titles of employees currently working in the Customer Service department.

-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

SELECT titles.title AS Title, 
	COUNT(dept_emp.emp_no) AS Count
FROM dept_emp

-- Didn't need to join employees
-- LEFT JOIN employees
-- ON dept_emp.emp_no = employees.emp_no

LEFT JOIN departments
ON dept_emp.dept_no = departments.dept_no

LEFT JOIN titles
ON dept_emp.emp_no = titles.emp_no

WHERE departments.dept_name = 'Customer Service'
	AND dept_emp.to_date LIKE '9999%'
	AND titles.to_date LIKE '9999%'
GROUP BY titles.title
ORDER BY titles.title;

-- 5. Find the current salary of all current managers.

-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987

SELECT departments.dept_name AS 'Department Name', 
	CONCAT(employees.first_name,
		' ',
        employees.last_name) AS 'Name',
    CONCAT('$ ', FORMAT(salaries.salary, 2)) AS 'Salary'
FROM dept_manager

LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no

LEFT JOIN departments
ON dept_manager.dept_no = departments.dept_no

LEFT JOIN salaries
ON dept_manager.emp_no = salaries.emp_no
	AND salaries.to_date LIKE '9999%'

WHERE dept_manager.to_date LIKE '9999%'
-- 	AND salaries.to_date LIKE '9999%'
ORDER BY departments.dept_name;

-- 6. Find the number of current employees in each department.

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

SELECT departments.dept_no,
	departments.dept_name,
    COUNT(dept_emp.emp_no) AS num_employees
FROM departments

LEFT JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
	AND dept_emp.to_date LIKE '9999%'

LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no

-- WHERE dept_emp.to_date LIKE '9999%'
GROUP BY departments.dept_no, departments.dept_name
-- Always GROUP BY non aggregated fields
ORDER BY departments.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+

SELECT departments.dept_name,
	ROUND(AVG(salaries.salary), 2) AS average_salary
FROM departments

LEFT JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no

LEFT JOIN salaries
ON dept_emp.emp_no = salaries.emp_no

WHERE dept_emp.to_date LIKE '9999%'
	AND salaries.to_date LIKE '9999%'
GROUP BY departments.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

SELECT employees.first_name,
	employees.last_name
FROM employees

LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
-- USING(emp_no)

LEFT JOIN departments
ON dept_emp.dept_no = departments.dept_no
-- USING(dept_no)

LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no
-- USING(emp_no)

WHERE departments.dept_name = 'Marketing'
	AND dept_emp.to_date LIKE '9999%'
	AND salaries.to_date LIKE '9999%'
ORDER BY salaries.salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?

-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

SELECT employees.first_name,
	employees.last_name,
	salaries.salary,
    departments.dept_name
FROM dept_manager

LEFT JOIN employees
ON dept_manager.emp_no = employees.emp_no

LEFT JOIN departments
ON dept_manager.dept_no = departments.dept_no

LEFT JOIN salaries
ON dept_manager.emp_no = salaries.emp_no

WHERE dept_manager.to_date LIKE '9999%'
	AND salaries.to_date LIKE '9999%'
ORDER BY salaries.salary DESC
LIMIT 1;

-- 10. Determine the average salary for each department. 
-- Use all salary information and round your results.

-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+

SELECT departments.dept_name,
	FORMAT(AVG(salaries.salary), 0) AS average_salary
FROM departments

LEFT JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no

LEFT JOIN salaries
ON dept_emp.emp_no = salaries.emp_no

GROUP BY departments.dept_no
ORDER BY average_salary DESC;

-- 11. Bonus Find the names of all current employees, 
-- their department name, 
-- and their current manager's name.

-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
--  Huan Lortz   | Customer Service | Yuchang Weedman

SELECT CONCAT(employees.first_name,
			' ',
			employees.last_name) AS 'Employee Name',
		departments.dept_name AS 'Department Name',
        employees.emp_no,
		(SELECT employees.last_name 
			WHERE dept_manager.emp_no > 0) AS 'Manager Name',
		dept_manager.emp_no AS 'Manager_emp_no',
        (CASE 
			WHEN dept_manager.emp_no > 0 then employees.last_name
 			ELSE NULL
 			END) AS Manager_last_name

-- USING MATCH
--         (SELECT employees.last_name
-- 				FROM employees
--                 WHERE MATCH (dept_manager.emp_no) AGAINST(employees.emp_no)) AS 'Manager LN'

-- USING CASE
-- 		(CASE 
-- 			WHEN dept_manager.emp_no > 0 then employees.last_name
--  		ELSE NULL
--  		END) AS Manager_last_name

FROM dept_emp

LEFT JOIN employees
ON employees.emp_no = dept_emp.emp_no
	AND dept_emp.to_date LIKE '9999%'

LEFT JOIN dept_manager
ON dept_emp.dept_no = dept_manager.dept_no
	AND dept_manager.to_date LIKE '9999%'

LEFT JOIN departments
ON dept_emp.dept_no = departments.dept_no

-- TEST one manager and one employee with manager
WHERE dept_emp.emp_no = '466852' 
 		OR dept_emp.emp_no = '111939';

-- 12. Bonus Who is the highest paid employee within each department.



-- PREVIOUS ATTEMPTS prior to learning SubQueries
SELECT departments.dept_name AS 'Department',
	CONCAT(employees.first_name, ' ', employees.last_name)AS 'Employee Name',
	CONCAT('$ ', FORMAT(salaries.salary, 2)) AS 'Salary'
FROM departments

LEFT JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
	AND dept_emp.to_date LIKE '9999%'
    AND (SELECT MAX(salary)
			FROM salaries)

LEFT JOIN salaries
ON dept_emp.emp_no = salaries.emp_no
	AND salaries.to_date LIKE '9999%'

LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no

-- WHERE MAX(salaries.salary)
GROUP BY employees.first_name, employees.last_name, departments.dept_no, salaries.salary
ORDER BY Salary DESC
LIMIT 1;

-- 12. TRY THIS
SELECT departments.dept_name AS 'Department', 
	CONCAT(employees.first_name, ' ', employees.last_name) AS 'Name',
	FORMAT(MAX(salaries.salary), 0) AS 'Salary'
FROM employees

LEFT JOIN departments
ON departments.dept_no = dept_emp.dept_no

LEFT JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no

LEFT JOIN salaries
ON dept_emp.emp_no = salaries.emp_no

LEFT JOIN employees
ON dept_emp.emp_no = employees.emp_no

GROUP BY departments.dept_no, employees.first_name, employees.last_name
ORDER BY MAX_Salary DESC;
