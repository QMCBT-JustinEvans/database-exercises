-- 1. Open MySQL Workbench and login to the database server
-- 2. Save your work in a file named tables_exercises.sql
-- 3. Use the employees database. Write the SQL code necessary to do this.
USE employees;

-- 4. List all the tables in the database. Write the SQL code necessary to accomplish this.
SHOW TABLES;

-- 5. Explore the employees table. What different data types are present on this table?
-- int, date, varchar(14), varchar(16), enum('M','F'), date
DESCRIBE employees;

-- 6. Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
-- All Tables carry emp_no int as a numeric primary key; The salaries table also carries a salary column as int
DESCRIBE departments;
DESCRIBE dept_emp;
DESCRIBE dept_manager;
DESCRIBE employees;
DESCRIBE salaries;
DESCRIBE titles;

-- 7. Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
-- All of the tables contain string type except the salaries table (char, varchar, enum).
-- departments [char(4), varchar(40)], dept_emp [char(4)], dept_manager [char(4)], employees [varchar(14), varchar(16), enum('M','F')], titles [varchar(50)]

-- 8. Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
-- All tables have date type columns except the departments table (dept_emp, dept_manager, employees, salaries, titles).alter

-- 9. What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- The employees and departments tables have no direct relationships but they are merged on the dept_emp table linking both their primary keys as a relationship.alter

-- 10. Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;
-- CREATE TABLE `dept_manager` (
--  `emp_no` int NOT NULL,
--  `dept_no` char(4) NOT NULL,
--  `from_date` date NOT NULL,
--  `to_date` date NOT NULL,
--  PRIMARY KEY (`emp_no`,`dept_no`),
--  KEY `dept_no` (`dept_no`),
--  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT