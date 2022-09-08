SELECT first_name, last_name
FROM employees.employees;

SELECT DISTINCT first_name FROM employees.employees;

SELECT * FROM numbers.numbers2
WHERE supergroup = 'one';

SELECT DISTINCT category FROM numbers.numbers2
WHERE supergroup = 'one';

SELECT * FROM employees.employees
WHERE emp_no < 10011;

SELECT * FROM employees.employees
WHERE gender != 'M'
AND birth_date BETWEEN 1950-01-01 AND 1960-01-01;