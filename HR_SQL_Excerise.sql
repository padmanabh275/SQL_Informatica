/* Excersise 1C - HR Database */
use HR;

/*1. Display all information in the tables EMP and DEPT.*/
select * from employees,departments;

/*2. Display only the hire date and employee name for each employee.*/

select hire_date,first_name,last_name from employees;

/*3. Display the ename concatenated with the job ID, separated by a comma and space, and
name the column Employee and Title*/

select concat (first_name,' ,',job_id ) as employee from employees;

/*4. Display the hire date, name and department number for all clerks.*/

select * from employees;
select hire_date,first_name,department_id from employees where job_id LIKE '%CLERK';

/*5. Create a query to display all the data from the EMP table. Separate each column by a
comma. Name the column THE_OUTPUT*/

select * from employees;
select concat (employee_id,',',first_name,',',last_name,',',email,',',phone_number,',',hire_date,',',job_id,',',salary,',',commission_pct,',',manager_id,',',department_id) as The_output
from employees;

/*6. Display the names and salaries of all employees with a salary greater than 2000.*/

select first_name,last_name,salary from employees where salary>2000;

/*7. Display the names and dates of employees with the column headers “Name" and “Start Date"*/
select * from employees;
select concat (first_name,' ',last_name) as name,(hire_date) as "start date" from employees;

/*8. Display the names and hire dates of all employees in the order they were hired.*/

select first_name,last_name,hire_date from employees order by hire_date;

/*9. Display the names and salaries of all employees in reverse salary order.*/

select first_name,last_name,salary from employees order by salary desc;

/*10. Display ‘ename’ and ‘deptno’ who are all earned commission and display salary in reverse
order*/

select * from employees;
select first_name,last_name,department_id from employees where commission_pct >0 order by salary desc;

