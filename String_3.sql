/* Assignment 3 - Strings */

use hr;

/* 1. query to display employees last name only for the string's 2'5 position with the letter capitalized
all other letters in lowercase, give each col an appropriate label */
select * from employees;
select lower(first_name) as Name, UPPER(LEFT(last_name,1))+LOWER(SUBSTRING(last_name,2,5)) as last_name
from employees;

/* 2. query to display emp firstname and last name along with a '-'in between
also displays month on which emp has joined.*/
select concat (first_name,'-' ,last_name) as Name, month(hire_date)
from employees;

/* 3 query for lastname if half of the salary is greater then 10 thousand then increase the salary by 
10% else by 11.5% along with the bonus amount of Rs 1500 each. Provide each col appropriate label.*/
select * from employees
select last_name,salary, 
case 
when (salary/2)>10000 then  salary+(salary*0.10) + 1500
else salary+(salary*0.115) + 1500
end  as  New_sal
from employees;


/* 4 Display emp_id by appending 2 0s afer 2nd digit and '-E' in the end, deparmentid,salary of the
manager name all in upper case,if the manager name consists of 'z' replace it with '$'. */
select * from employees;
select employee_id,concat (left(employee_id,2),'00',substring(cast(employee_id as varchar),3,len(employee_id)),'-E'),
dept.department_id,replace (concat(emp.first_name,' ',emp.last_name),'z','$')
from employees as emp
join departments as dept on
emp.department_id=dept.department_id and
emp.employee_id in (select distinct(manager_id) from employees)

/* 5 query for employee last name with the first letter capitalized and all the other letters in lower case,length
of the names,for all the employees whose names starts with J,A or M. give each column an appropriate label.
sort the results by employee last name */

select  UPPER(LEFT(last_name,1))+LOWER(SUBSTRING(last_name,2,LEN(last_name))) as Names
from employees 
where last_name like 'J%' or last_name like 'A%' or last_name like 'M%'

/* 6 display the last name and salary for all employees. format the salary to be 15 characters long, left padded with $. labl the columnn salary*/

select last_name,concat('$', (cast(salary as varchar(15))))+replicate('$',len(salary)) as salary_new
from employees

/* 7 display the employee name if it is palindrome */
select first_name
from employees
where reverse (first_name)= first_name;

/*8 display the first names of all employees with initcaps */

select initcap (first_name)
from employees;
/*Msg 195, Level 15, State 10, Line 57
'initcaps' is not a recognized built-in function name.*/

/*9 From locations table,extract the word between first and second space from the stree_address column */

select * from locations
select left(substring(street_address,
charindex(' ',street_address)+1,len(street_address)),
charindex(' ',substring(street_address,charindex(' ',street_address)+2,len(street_address))))
from locations

/*charindex(substring (street_address,charindex(' ',street_address)+2,len(street_address)))
from locations*/


/*10 Extract the first letter from first_name column and append it with the last_name. also add '@systechusa.com'
at the end. Name the column as email address. All characters should be displayed in lower. 
display along with the first_name */

select first_name,lower (concat (left(first_name,1),'',last_name,'@systechusa.com')) as Email_Address
from employees


/*11 display the names and job title of all employees with the same job as Trenna */
select * from employees
select first_name,job_id 
from employees as emp
join 
departments as dept on
emp.department_id=dept.department_id
where emp.job_id in (select job_id from employees where first_name='Trenna')


/*12 display the names and department names of all the employees working in the same city as Trenna */
select * from employees
select * from departments
select * from locations
select emp.first_name,dept.department_name,loc.city
from employees as emp
join 
departments as dept on
emp.department_id=dept.department_id
join 
locations as loc on
loc.location_id=dept.location_id
where dept.department_id in (select department_id from employees where first_name='Trenna')


/*13 display the name of the employee whose salary is lowest */

select first_name,salary
from employees
where salary in (select min(salary) from employees )

/*14 display the names of all employees except the lowest paid */

select first_name,salary
from employees
where salary !=(select min(salary) from employees)



