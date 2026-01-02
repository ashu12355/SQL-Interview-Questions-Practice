-- 1. How to retrieve the second-highest salary of an employee?
SELECT MAX(salary)
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

select salary from employees;

-- 2. How to get the nth highest salary in ?


-- 3. How do you fetch all employees whose salary is greater than the average salary?

SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees); 

-- 4. Write a query to display the current date and time in .

SELECT CURRENT_TIMESTAMP;

-- 5. How to find duplicate records in a table?

SELECT salary ,COUNT(*)
FROM employees
GROUP BY salary
HAVING COUNT(*) > 1;

-- Adding employee_id with the salary

SELECT e.employee_id , e.name , e.salary
FROM employees e
JOIN (
	SELECT salary
    FROM employees
    GROUP BY salary
    HAVING COUNT(*) > 1
) dup
ON e.salary = dup.salary
ORDER BY e.salary, e.employee_id;

-- 6. How can you delete duplicate rows in ?

-- 7. How to get the common records from two tables?

SELECT join_date 
FROM employees
INTERSECT
SELECT hire_date FROM employees;

-- 8. How to retrieve the last 10 records from a table

SELECT *
FROM employees
ORDER BY employee_id DESC
LIMIT 10;

-- 9. How do you fetch the top 5 employees with the highest salaries?

SELECT * FROM employees
ORDER BY salary DESC
LIMIT 5;

-- 10. How to calculate the total salary of all employees?

SELECT SUM(salary)
FROM employees;

-- 11. How to write a query to find all employees who joined in the year 2020?
SELECT *
FROM employees
WHERE YEAR(join_date) = 2020;

-- 12. Write a query to find employees whose name starts with 'A'.

SELECT * 
FROM employees
WHERE first_name LIKE 'A%';


-- 13. How can you find the employees who do not have a manager?

SELECT *
FROM employees
WHERE manager_id IS NULL;

-- 14. How to find the department with the highest number of employees?

SELECT department_id , count(*) 
FROM employees
GROUP BY department_id
ORDER BY count(*) DESC
LIMIT 1;


-- 15. How to get the count of employees in each department?

SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id;

-- and department name 

SELECT d.department_id,d.department_name , dep.emp_count
FROM departments d
JOIN (
	SELECT department_id , COUNT(*) AS emp_count
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) > 1
) dep
ON d.department_id = dep.department_id
ORDER BY d.department_name , d.department_id;

-- 16. Write a query to fetch employees having the highest salary in each department.

SELECT department_id , employee_id , salary
FROM employees e
WHERE salary = (SELECT MAX(salary) 
FROM employees
WHERE e.department_id = department_id);

-- 17. How to write a query to update the salary of all employees by 10%?
UPDATE employees
SET salary = salary + salary*0.1;

-- 18. How can you find employees whose salary is between 80,000 and 1,00,000?

SELECT salary,employee_id 
FROM employees
WHERE salary BETWEEN 80000 AND 100000;

-- 19. How to find the youngest employee in the organization?

SELECT *
FROM employees
ORDER BY birth_date DESC
LIMIT 1;

-- 20. How to fetch the first and last record from a table? 

(SELECT *
FROM employees
ORDER BY employee_id ASC
LIMIT 1)
UNION ALL
(SELECT *
FROM employees
ORDER BY employee_id DESC
LIMIT 1
);

-- 21. Write a query to find all employees who report to a specific manager.

SELECT * 
FROM employees
WHERE manager_id IS NOT NULL;

-- 22. How can you find the total number of departments in the company?

SELECT COUNT(DISTINCT department_id) AS total_co
FROM employees;

-- 23. How to find the department with the lowest average salary?

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY AVG(salary) ASC
LIMIT 1;

-- 24. How to delete all employees from a department in one query?

DELETE FROM employees
WHERE department_id IS NOT NULL;

-- 25. How to display all employees who have been in the company for more than 5 years?


SELECT *
FROM employees
WHERE DATEDIFF(CURDATE(),join_date) > 1825; -- 5 years ≈ 5 × 365 = 1825 days 

-- 26. How to find the second-largest salary/value from a table?

SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- 27. How to write a query to remove all records from a table but keep the table structure?

TRUNCATE TABLE emploee;

-- 28. Write a query to get all employee records in XML format.

SELECT employee_id, first_name , last_name
FROM employees
FOR XML AUTO; -- for sql -- my sql not works

-- 29. How to get the current month’s name from ?

SELECT MONTHNAME(CURDATE());

-- 30. How to convert a string to lowercase in ?

SELECT LOWER('ASDFGHJ');

-- 31. How to find all employees who do not have any subordinates?
	-- query is meant to find employees who are not managers.

SELECT e.*
FROM employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM employees sub
    WHERE sub.manager_id = e.employee_id
);

-- 32. Write a query to calculate the total sales per customer in a sales table.


SELECT customer_id , SUM(sales_amount)
FROM sales
GROUP BY customer_id;

-- 33. How to write a query to check if a table is empty?

SELECT CASE
	WHEN EXISTS(SELECT 1 FROM employees)
    THEN 'NOT EMPTY'
    ELSE 'EMPTY'
    END;

-- 35. Write a query to fetch employees whose salary is a multiple of 1,000.

SELECT *
FROM employees
WHERE salary % 1000 = 0;

-- 36. How to fetch records where a column has null values?

SELECT *
FROM employees
WHERE bonus IS NULL;

-- 37. How to write a query to find the total number of employees in each job title?

SELECT job_title , COUNT(*)
FROM employees
GROUP BY job_title;

-- 38. Write a query to fetch all employees whose names end with ‘s’

SELECT first_name
FROM employees
WHERE first_name LIKE '%s';

-- 39. How to find all employees who work in both departments 101 and 102?

SELECT employee_id
FROM employees
WHERE department_id IN(101,102)
GROUP BY employee_id
HAVING COUNT(DISTINCT department_id) = 2;

-- 40. Write a query to fetch the details of employees with the same salary.
select * 
from employees
where salary IN ( select salary
	from employees
    group by salary
    having count(*) > 1
    );
    
-- 41. How to update salaries of employees based on their department

update employees
set salary = CASE
	WHEN department_id = 101 THEN salary*1.10
    WHEN department_id = 102 THEN salary*1.05
    ELSE salary
END;

-- 42. How to write a query to list all employees without a department?

select * 
from employees
where department_id = NULL;

-- 43. Write a query to find the maximum salary and minimum salary in each department

select department_id,max(salary),min(salary)
from employees
group by department_id ;

-- 44. How to list all employees hired in the last 6 months?

select * from
employees
where hire_date > ADDDATE(CURDATE(),INTERVAL -6 MONTH);


select ADDDATE(CURDATE(), INTERVAL -6 MONTH);

-- 45. Write a query to display department-wise total and average salary

select department_id,  sum(salary) AS total_salary ,avg(salary) AS average_salary
from employees
group by department_id;

-- 46. How to find employees who joined the company in the same month and year as their manager?

select e.name, e.employee_id , e.name
from employees e
JOIN employees m ON e.manager_id = m.employee_id
WHERE MONTH(e.join_date) = MONTH(m.join_date)
AND YEAR(e.join_date) = YEAR(m.join_date)
;

-- 47. Write a query to count the number of employees whose names start and end with the same letter.

select count(*) AS Total_count
from employees
where first_name LIKE 'a%'
AND first_name LIKE '%e'
;

-- 48. How to retrieve employee names and salaries in a single string?

SELECT concat(first_name,' Earns: ',salary) AS EmployeeInfo 
FROM employees;

-- 49. How to find employees whose salary is higher than their manager's salary

select e.employee_id ,e.first_name , m.employee
from employees e
JOIN employees m ON
e.manager_id = m.employee_id
where e.salary > m.salary;

-- 50. Write a query to get employees who belong to departments with less than 3 employees.
    
select * from
employees
where department_id IN (
	select department_id from employees
    group by department_id 
    having count(*) < 5
    );

-- 51. How to write a query to find employees with the same first name?

select *
from employees
where first_name IN (
	select first_name from employees
    group by first_name 
    having count(*) > 1
    );

-- 52. How to write a query to delete employees who have been in the company for more than 15 years

DELETE FROM employees
WHERE DATEDIFF(CURDATE(), join_date) > 5475; -- 365*15

-- 53. Write a query to list all employees working under the same manager.

select * 
from employees e
JOIN employees m
ON e.manager_id = m.employee_id
ORDER BY m.employee_id;

-- ORDER BY = sorting
-- GROUP BY = grouping + aggregation

-- 54. How to find the top 3 highest-paid employeesin each department?

select * 
from (select e.*,
ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
FROM employees e) AS ranked_employees
WHERE rnk <= 3;

-- 55. Write a query to list all employees with more than 5 years of experience in each department

select * 
from employees
where DATEDIFF(curDATE(),join_date) > 365*5;


-- 56. How to list all employees in departments that have not hired anyone in the past 2 years?

select *
from employees
where department_id IN (SELECT department_id
	FROM employees
    GROUP BY department_id
    HAVING MAX(hire_date) < adddate(CURDATE(),INTERVAL-2 YEAR));

-- 57. Write a query to find all employees who earn more than the average salary of their department.

select *
from employees e
where salary > (Select avg(salary) from employees 
where department_id = e.department_id );

-- 58. How to list all managers who have more than 5 subordinates?

select *
from employees
where employee_id IN (select manager_id 
from employees
group by manager_id
having count(*) >= 5);

-- 59. Write a query to display employee names and hire dates in the format "Name - MM/DD/YYYY"
 select concat(first_name,'-',date_format(hire_date,'%m/%d/%y')) AS
 employee_info
 FROM employees;
 
 -- 60. How to find employees whose salary is in the top 10%? [top 10% highest-paid employees.]
 
 select *
 FROM (
	select e.*,
		NTILE(10) OVER (ORDER BY salary ASC) AS decile
	FROM employees e
    ) ranked
    WHERE decile = 10;

-- 61. Write a query to display employees grouped by their age brackets(e.g.,20-30, 31-40, etc.).

select case
	when age between 20 and 30 then '20-30'
    when age between 31 and 40 then '31-40'
    else '41+'
 end as age_bracket,
 count(*)
 from employees
 group by age_bracket;
 
 -- 62. How to find the average salary of the top 5 highest-paid employees in each department?
 
select department_id , avg(salary)
from ( select department_id , salary,
	DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rankk
    from employees ) As ranked_employees
where rankk <= 5
GROUP by department_id;

-- 63. How to calculate the percentage of employees in each department?

SELECT department_id,
       (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees)) AS percentage
FROM employees
GROUP BY department_id;

-- 64. Write a query to find all employees whose email contains the domain '@example.com'.
SELECT *
FROM employees
WHERE email LIKE '%@example.com';

-- 65. How to retrieve the year-to-date sales for each customer?


select customer_id , sum(sales_amount)
from sales
where sale_date between '2024-01-01' AND curdate()
group by customer_id;


-- 66. Write a query to display the hire date and day of the week for each employee.

select name,hire_date , DAYNAME(hire_date ) from employees;

-- 67. How to find all employees who are older than 30 years?

select * from employees where
datediff(curdate(),birth_date)/365 > 30;

-- 68. Write a query to display employees grouped by their salary range (e.g., 0-20K, 20K-50K).
SELECT CASE
WHEN salary BETWEEN 0 AND 20000 THEN '0-20K'
WHEN salary BETWEEN 20001 AND 50000 THEN '20K-50K' 
ELSE '50K+'
END AS salary_range, 
COUNT(*)
FROM employees 
GROUP BY salary_range;

-- 69. How to list all employees who do not have a bonus?
SELECT e.employee_id ,  e.first_name , e.last_name , e.bonus
FROM employees e
WHERE bonus IS NULL;


-- 70. Write a query to display the highest, lowest, and average salary for each job role.

select max(salary) , min(salary) , avg(salary) ,job_role
from employees
GROUP BY job_role ;






