use HR;

/*1 Write a query to display the last name and hire date of any employee in the same department as Sales */

select * from employees;
select * from departments;
select emp.last_name,concat ( day (emp.hire_date),'/' ,month (emp.hire_date),'/',year (emp.hire_date)) as date1 ,dept.department_name
from employees as emp 
join departments as dept 
on emp.department_id=dept.department_id
where dept.department_name= 'Sales'

select last_name,hire_date
from employees as emp 
where emp.department_id = (select department_id from departments where department_name = 'Sales')

/* 2. create a query to display the employee numbers and lastg names of all the employees who earn more than the average salary . sort the results 
in ascending order of salary*/

select * from employees;

select employee_id,last_name,salary,(select avg (salary) from employees) as Avg_Sal
from employees as emp
where emp.salary > (select avg (salary)  from employees)
order by emp.salary asc;


/*3 Write a query that displays the employee nos and last name of all the employees who work in a dept with any employee whose last name contains 
a 'u' */
select * from employees;
select * from departments;
select employee_id,last_name 
from employees as emp 
where department_id in (select department_id from departments where last_name like '%u%');

/*4 display the last name ,department no,and job id of all the employees whose department locatoin is atlanta' */
select * from employees;
select * from departments;
select * from [dbo].[locations];

select last_name,dept.department_id,job_id
from employees as emp 
join departments as dept on 
emp.department_id=dept.department_id
where  location_id in ( select location_id from locations as loc where loc.city='ATLANTA');

/*5 display the last name and salary of every employee who reports to Steven */
select * from employees;
select * from departments;
select * from [dbo].[locations];
select last_name,salary
from employees as emp 
where manager_id in (select top 1 employee_id from employees as emp2 where first_name ='Steven' )  

/* 6.display the depatment number,last name and job id for every employee in the  Executive  deparment */
select * from employees;
select * from departments;
select * from [dbo].[locations];
select department_id,last_name,job_id
from employees as emp 
where department_id in (select department_id from departments where department_name='Executive');
/* note operations values were zero so, i have changed it to Executive to check wheather the logic is working or not */

/* 7 Modify the above query to display the employee nos,last name and salaries of all the employees who earn 
more then average salary and work in a department with any employee with a 'u' in their name */
select employee_id,last_name,salary
from employees as emp 
where department_id in (select department_id from departments where department_name='Executive') and 
salary > (select avg (salary) from employees) and last_name in (select last_name from  employees where last_name like '%u%')
/* the above doesn't result in any data */

/*8 display the names of all the employees whose job title is the same as anyone in the sales department */
select * from employees;
select * from departments;
select first_name,last_name
from employees 
where job_id in (select job_id from departments as dep join employees as emp on emp.department_id=dep.department_id
where department_name='Sales')

/* 9 write a compound query to produce a list of employees showing raise percentages,employee id,and salaries
employees in department 1 and are given a 5% raise, employees in dept 2 are given 10 % raise dept 4 & 5 are given 
15% raise and dept 6 are not given a raise */
select * from employees;
select * from departments;
select * from  [dbo].[jobs];
select first_name,last_name,employee_id,salary,
case 
when  department_id= 10 then abs (0.05*salary)+salary
when  department_id= 20 then abs (0.10*salary)+salary  
when  department_id= 30 then abs (0.05*salary)+salary  
when  department_id= 40 then abs (0.15*salary)+salary  
when  department_id= 50 then abs (0.15*salary)+salary  
when  department_id= 60 then abs (0.00*salary)+salary  
end  raise_percentages
from employees as emp where department_id in ( select department_id from departments where department_id in ('10', '20','30','40','50','60')) ;

/* 10 write a query to display top 3 earners in the employees table. display the last name,first name */

select first_name,last_name,salary
from employees as emp
where salary in (select top 3 salary from employees)order by salary desc); 

/* 11 display the name of all the employees with their salary and commission earned. employees with null commission should
have 0 in the commission column */

select first_name,salary, (salary*commission_pct) as commission
from employees as emp 
where commission_pct in  (select coalesce (NULL,commission_pct,0) from employees) 

/* 12 display the manager(name) with the top 3 salaries along with their salaries and department information */

select * from employees;
select * from departments;
select * from [dbo].[locations];
select top 3 emp.first_name,emp.last_name,emp.salary
from employees as emp 
where first_name in (select emp1.first_name as Manager from employees emp inner join employees as emp1 on emp.employee_id = emp1.manager_id)

