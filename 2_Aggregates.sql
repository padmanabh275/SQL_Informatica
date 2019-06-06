/* Excersise 2 Aggregates */

use HR; 

/* 1 display max,min,avg salary and commission earned */
select * from [dbo].[employees];
select max(salary), min(salary), avg (salary), sum (commission_pct*salary) as Commission from employees as emp;

/*2. display the dept no,total salary payout and total commision payout of each dept */
select * from departments
select * from employees
select emp.department_id,sum(salary) as Salary_Payout,sum (commission_pct*salary) as Commision_payout
from employees as emp
group by (department_id)

/* 3. display the dept no and no of employees in each dept */
select emp.department_id, count(employee_id) as No_Employees
from employees as emp
group by (department_id)

/*4 display the dept no and total salary of each dept */
select emp.department_id, sum(salary) as Salary
from employees as emp
group by (department_id)

/* 5. Display the Employees Name who doesnt earn commission. order the result set without using the column name */
select * from employees
select emp.first_name
from employees as emp
where emp.commission_pct is not null
order by 1 

/* 6 display employees name,salary,and commission. employee doesnt earn commission display as no commission 
name the cols appropriately */

select emp.first_name,emp.salary,
case 
when commission_pct is null then 'no_comm'
else cast (commission_pct as varchar) 
end as Commission 
from employees as emp
group by emp.first_name,emp.salary,commission_pct

/* 7 display the employees name,salary,commission multiplied by 2. employee doesnt earn commission display as no commission 
name the cols appropriately */

select emp.first_name,emp.salary,sum (emp.commission_pct* 2) as Commission 
from employees as emp
group by emp.first_name,emp.salary

/*8. display employee name,department id, who have the first name as another employees in the same department */

select * from employees
select first_name 
from employees 
where department_id=80

select first_name,department_id
from employees as emp 
group by department_id,first_name
having count(first_name) > 1;

/* 9 display sum of salaries for employees working under each manager */

select manager_id,sum(salary) as Salaries
from employees as emp 
group by manager_id 

/* 10 select managers name,count of employees working under and the department id of the manager */
select * from employees;

select count(emp.employee_id),emp.department_id,emp.first_name
from employees as emp 
join employees as emp2 
on emp.employee_id=emp2.manager_id 
/*where manager_id=employee_id*/
group by emp.department_id,emp.first_name


/* 11 select emp name,department id and the salary.group the result with the manager name and the employee last name 
should have second letter as 'a' */

/*select count(employee_id),department_id,last_name,salary
from employees as emp 
where manager_id=employee_id and last_name like '_a%'
group by department_id,last_name,salary,manager_id*/

select emp.first_name,count(emp.department_id),emp.last_name,emp.salary
from employees as emp ,departments as dept 
where emp.employee_id in (select distinct(manager_id) from employees)
and emp.last_name like '_a%' 
group by emp.department_id,emp.last_name,emp.salary,emp.manager_id,emp.first_name


/*12 display the avg of sum of the salaries and group the result with the deparmentid. order the result with departmentid */

select sum(salary),department_id
from employees as emp 
group by department_id
order by department_id

/* 13 select the maximum salary of each deparment along with the department id */
select * from employees
select max(salary) as Salary,department_id
from employees as emp 
group by department_id

/*14 display the commission, if not null display 10% of salary , if null display a default value 1 */

select commission_pct,first_name,
case 
when commission_pct is not null then 0.10*salary
when commission_pct is null then 1
end as Commission
from employees as emp 
