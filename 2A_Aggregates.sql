/* 2A	(AGGREGATES */

/* 1. use case function write a query to grade all the employees based on the value of the column in job_id as per the following 
date job accounting grade a job research grade b sales grade c operations d none of the above d */

use hr;

select * from employees;
select * from jobs;
select * from departments;

select job_id, 
case 
when department_name='accounting' then 'Grade A' 
when department_name='research' then 'Grade B' 
when department_name='sales' then 'Grade C'
when department_name='operations' then 'Grade D'
when department_name='null'  then 'Grade E'
end as Grades
from employees as emp
join departments as dept 
on emp.department_id=dept.department_id;

/* 2 display the names of all the employees with their job title,their current salary and their salary following a 10%
raise for clerks and a 7% pay rise for all the employees. */
select * from employees;
select * from departments;
select first_name,job_id,salary,
case 
when job_id='CLERK' then (0.10*salary)+salary
when job_id != 'CLERK' then (0.07 *salary)+salary
end as Pay_rise 
from employees as emp 

/* 3 display the names of all the employees with their salary and commission earned. employees with null commission 
should have 0 in the commission column */
select emp.first_name,salary,coalesce (commission_pct*salary,0) as Commission_earned
from employees as emp
group by first_name,salary,commission_pct

/* 4 display the name of all employees with the total they have earned (i.e. salary plus commission */
select emp.first_name,salary,coalesce (commission_pct*salary+salary,0) as Commission_earned
from employees as emp
group by first_name,salary,commission_pct

/* 5 repeat the display for the last question but this time display in descending order of earnings */
select emp.first_name,salary,coalesce (commission_pct*salary+salary,0) as Commission_earned
from employees as emp
group by first_name,salary,commission_pct
order by emp.commission_pct desc

/* 6 display the manager name who earns the top 3 salaries along with their salaries and department */
select * from employees;
select distinct top 3 emp.first_name,emp.last_name,emp.job_id, emp.salary
from employees as emp
join 
employees as emp2 on 
emp.employee_id=emp2.manager_id
order by emp.salary desc

/*7 display the name of the employee whose job title is the same as anyone in sales dept */
select * from departments;
select * from employees;
select * from jobs;
select first_name,last_name,job_id,dept.department_name
from employees as emp 
join departments as dept on 
emp.department_id=dept.department_id
where dept.department_name='Sales';

/*8 display the name of the employee who works in a deparment that employs an analyst */
select emp.first_name,emp.last_name,dept.department_name
from employees as emp 
join departments as dept on 
emp.department_id=dept.department_id
where dept.department_name='analyst'
group by emp.first_name,emp.last_name,dept.department_name

/* 9 create a view called employees_vu based on the employee nos,employee names and department nos 
from the employees table.change the heading for the employee. display the same */
/* out of the course but it is not coming though the sysntax is correct */

create view employees_vu
as select employee_id,first_name as employee,department_id
from employees

/* 10 create a view named dept3 that contacts emp no,emp last name , dept nos of all 
employees in the dept 30. label the views as empno,employee and deptno. do not 
allow an employee to be reassigned to another dept through the view */
select * from employees;
create view dept3
as select employee_id as empno,last_name as employee,department_id as deptno
from employees 
where department_id=30;
/*Msg 262, Level 14, State 18, Procedure dept3, Line 91
CREATE VIEW permission denied in database 'HR'.*/



-- trying ctc using the count of n salary 
-- 2 highest salary from subquery 
select max(salary) from employees
where salary <  (select max(salary) from employees)

select top 1 salary from (select distinct top 3 salary from employees 
order by salary  desc ) result 
order by salary 

use hr
select * from employees;
with result as 
(
select salary,dense_rank() over (order by salary desc) as denserank
from employees
)
select top 1 salary
from result
where result.denserank=3
