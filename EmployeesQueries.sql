USE employees;

/* Retrieve all uniqe salary values */ 
SELECT DISTINCT salary FROM salaries;

/* Find the average salary, minimum and maximum salary */
SELECT avg(Salary), min(Salary),max(Salary) FROM salaries;

/* Find the number of male and female employees and order the count in descending order */
SELECT gender, COUNT(*) FROM EMPLOYEES GROUP BY gender ORDER BY COUNT(*) DESC;

/* Find the names of the employees who work in more than one department  */
SELECT first_name, last_name, COUNT(*) AS no_of_depts FROM EMPLOYEES AS E, DEPT_EMP AS D WHERE E.emp_no = D.emp_no GROUP BY D.emp_no HAVING COUNT(*)>1;

/* Display the number of hires based on the month */
SELECT DATE_FORMAT(hire_date, '%M') AS month, COUNT(*) AS total_hires FROM employees GROUP BY month ORDER BY total_hires DESC;

/* Find the employee number of those who joined the company prior to January 1, 1990 */
SELECT emp_no, hire_date FROM EMPLOYEES where hire_date < '1990-01-01';

/* Print first name of every employee, replacing letter 'a' with 'A' */
Select REPLACE(FIRST_NAME,'a','A') from EMPLOYEES;

/* Select names of employees with titles */
SELECT first_name, last_name FROM employees INNER JOIN titles ON employees.emp_no=titles.emp_no;