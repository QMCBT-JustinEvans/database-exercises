-- 1. Create a file named where_exercises.sql. Make sure to use the employees database.
USE employees;

-- 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
-- Enter a comment with the number of records returned.

-- Answer: 709 row(s) returned
SELECT * 
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, 
-- but use OR instead of IN. Enter a comment with the number of records returned. 
-- Does it match number of rows from Q2?

-- Answer: 709 row(s) returned same as Q2.
SELECT * 
FROM employees 
WHERE first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya';

-- 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', 
-- using OR, and who is male. Enter a comment with the number of records returned.

-- Answer: 441 row(s) returned 
-- I chose to separate gender first (once) rather than with each name search 
-- IOT reduce search time (0.205 vs 0.368)
SELECT * 
FROM employees
WHERE gender = 'M'
	AND (first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya');

SELECT * 
FROM employees
WHERE (first_name = 'Irena'
	OR first_name = 'Vidya'
	OR first_name = 'Maya')
	AND gender = 'M';
    
-- 5. Find all current or previous employees whose last name starts with 'E'. 
-- Enter a comment with the number of employees whose last name starts with E.

-- Answer: 7330 row(s) returned; BETWEEN function is Inclusive of 1st operator and Exclusive of 2nd operator.
SELECT last_name 
FROM employees 
WHERE last_name 
BETWEEN 'E' AND 'F';

SELECT COUNT(last_name)
FROM employees
WHERE last_name 
BETWEEN 'E' AND 'F';

-- 6. Find all current or previous employees whose last name starts or ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts or ends with E. 

-- Answer: 30723 row(s) returned that start OR end with 'E'
SELECT last_name 
FROM employees 
WHERE last_name LIKE 'E%'
	OR last_name LIKE '%E';

-- 6b. How many employees have a last name that ends with E, but does not start with E?

-- Answer: 23393 row(s) returned; I chose to SELECT last_name so I could visually verify my list
SELECT last_name 
FROM employees 
WHERE last_name NOT LIKE 'E%'
	AND last_name LIKE '%E';

-- 7. Find all current or previous employees employees whose last name starts and ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts and ends with E. 

-- Answer: 899 row(s) returned
SELECT last_name 
FROM employees 
WHERE last_name LIKE 'E%'
	AND last_name LIKE '%E';
-- Or... you could use LIKE 'E%E'

-- 7b. How many employees' last names end with E, regardless of whether they start with E?

-- Answer: 24292 row(s) returned
SELECT last_name 
FROM employees 
WHERE last_name LIKE '%E';

-- 8. Find all current or previous employees hired in the 90s. 
-- Enter a comment with the number of employees returned.

-- Answer: 135214 row(s) returned; I opened up the limit to "Don't Limit" IOT provide full list
-- since the question specifically said find in addition to give count (otherwise I could use COUNT).
SELECT last_name, hire_date
FROM employees 
WHERE hire_date LIKE '199%';

-- 9. Find all current or previous employees born on Christmas. 
-- Enter a comment with the number of employees returned.

-- Answer: 842 row(s) returned
SELECT last_name, birth_date
FROM employees 
WHERE birth_date LIKE '%12-25';

-- 10. Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with the number of employees returned.

-- Answer: 362 row(s) returned
SELECT last_name, hire_date, birth_date
FROM employees 
WHERE hire_date LIKE '199%'
	AND birth_date LIKE '%12-25';

-- 11. Find all current or previous employees with a 'q' in their last name. 
-- Enter a comment with the number of records returned.

-- Answer: 1873 row(s) returned
SELECT last_name
FROM employees 
WHERE last_name LIKE '%Q%';

-- 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. 
-- How many employees are found?

-- Answer: 547 row(s) returned; 
-- ran LIKE '%Q%' and then ran LIKE '$QU$'; subtracted difference to check answer
SELECT last_name
FROM employees 
WHERE last_name LIKE '%Q%'
	AND last_name NOT LIKE '%QU%';