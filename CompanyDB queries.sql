USE companyDB;

/* Retrieve all distinct salary values of every employee */
SELECT DISTINCT Salary FROM EMPLOYEE;

/* Retrieve the first name, address and salary of each employee whose last name is ‘English’ and who works for a department named either ‘Marketing’ or ‘Administration’ */
SELECT Fname, Address, Salary FROM EMPLOYEE, DEPARTMENT WHERE Lname = 'English' AND (Dname='Marketing' OR Dname='Administration') AND Dnumber=Dno;

/* Retrieve the last name and birthdate of each male employee whose salary is at least $20,000 and who works for either Department 4 or Department 5 */
SELECT Lname, Bdate FROM EMPLOYEE WHERE Gender='M' AND Salary>=20000 AND (Dno=4 OR Dno=5);

/*  Retrieve the names of all employees who do not have supervisors */
SELECT Fname, Lname FROM EMPLOYEE WHERE SuperSsn IS NULL;

/* List the names of managers who have at least one dependent */
SELECT Fname, Lname FROM EMPLOYEE WHERE EXISTS (SELECT * FROM DEPENDENT WHERE Ssn=Essn) AND EXISTS (SELECT * FROM DEPARTMENT WHERE Ssn=MgrSsn);

/* Retrieve the Social Security numbers of all employees who work on project numbers 100, 200, 300, or 400 */
SELECT DISTINCT E.Ssn FROM EMPLOYEE as E, WORKSON as W WHERE (W.Pno = 100 OR W.Pno=200 OR W.Pno=300 OR W.Pno=400) AND W.Essn = E.Ssn;

/* Find the average of the salaries of all employees, the maximum salary, and the minimum salary */
SELECT avg(Salary), min(Salary),max(Salary) FROM EMPLOYEE;

/* Find the sum of the salaries of all employees of the ‘Marketing’ department */
SELECT SUM(Salary) FROM EMPLOYEE, DEPARTMENT WHERE Dname='Marketing' AND Dnumber=Dno;

/* For each department, retrieve the department number, the number of employees in the department, and their average salary */
SELECT Dno, count(*),avg(Salary) FROM EMPLOYEE GROUP BY Dno;

/* For each project, retrieve the project number, the project name, and the number of employees from department 4 who work on the project */
SELECT Pnumber, Pname, COUNT(*) FROM PROJECT, WORKSON, EMPLOYEE WHERE Pnumber=Pno AND Ssn=Essn And Dno=4 GROUP BY Pnumber, Pname;

/* For each department that has more than two employees, retrieve the department number and the number of its employees who are making less than $80,000 */
SELECT Dnumber, COUNT(*) FROM DEPARTMENT, EMPLOYEE WHERE Dnumber=Dno AND Salary<80000 AND Dno IN (SELECT Dno FROM EMPLOYEE GROUP BY Dno HAVING COUNT(*)>2) GROUP BY Dnumber;

/* Retrieve the social security number of any employee who works on a project that is controlled by a department other than the one for which the employee lives */
SELECT DISTINCT Ssn FROM EMPLOYEE, PROJECT, WORKSON WHERE Ssn=Essn AND Pno=Pnumber AND (Address LIKE '%Houston%' OR Address LIKE '%Toronto%' OR Address LIKE '%Humble%' OR Address LIKE '%Bellaire%' OR Address like '%Spring%' AND Address!=Plocation);

/* For each department whose average employee salary is less than $80,000, retrieve the department name and the number of employees working for that department */
SELECT Dname, COUNT(*) FROM DEPARTMENT, EMPLOYEE WHERE Dnumber=Dno GROUP BY Dname HAVING AVG(Salary)<80000;

/* Retrieve the names of all employees who work in the department that has the employee with the highest salary among all employees */
SELECT Fname, Lname FROM EMPLOYEE WHERE Dno = (SELECT Dno FROM EMPLOYEE HAVING max(Salary));

/* Retrieve the names of employees who make at least $30,000 more than the employee who is paid the least in the company */
SELECT Fname, Lname FROM EMPLOYEE WHERE Salary>=30000+(SELECT MIN(Salary) FROM EMPLOYEE);

/* Fetch a project-wise count of employees sorted by project’s count in descending order */
SELECT Pno,COUNT(*) FROM EMPLOYEE, WORKSON WHERE Ssn=Essn GROUP BY Pno ORDER BY COUNT(*) DESC;

/* Write a SQL query to fetch a list of employees working on more than 2 projects and show the result in desc order */
SELECT Fname, Lname FROM EMPLOYEE WHERE(SELECT COUNT(*) FROM WORKSON WHERE Ssn=Essn)>2 ORDER BY Lname DESC, Fname DESC;

/* Write a query to fetch employee names and dependent records. Return employee details even if the dependent record is not present for the employee */
SELECT * FROM EMPLOYEE AS E LEFT OUTER JOIN DEPENDENT AS D ON E.Ssn = D.Essn UNION SELECT * FROM EMPLOYEE AS E RIGHT OUTER JOIN DEPENDENT AS D ON E.Ssn=D.Essn;

/* Write a query to fetch employee names and dependent records. Return employee details if the dependent record is present for the employee */
SELECT * FROM EMPLOYEE AS E, DEPENDENT AS D WHERE E.Ssn= D.Essn;

/* Fetch duplicate records based on essn and pno from the ‘WORKSON’ table */
SELECT Essn, Pno FROM WORKSON GROUP BY Essn,Pno HAVING COUNT(*) >2;