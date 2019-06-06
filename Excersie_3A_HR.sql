/* Excersise 3A HR Database */
use HR;

/*1. Write a query to display the last name, department number, department name for all employees */
select * from employees;
select * from departments;
select * from locations;
select * from jobs;
select * from job_history;
select * from countries;

select last_name,d.department_id,department_name from employees as e inner join departments as d on e.department_id=d.department_id;

/*2. Create a unique list of all jobs that are in department 40. Include the location of the department in the output. */
select d.department_name,l.city,l.country_id
 from employees as e join departments as d on e.department_id=d.department_id 
 join locations as l on d.location_id=l.location_id where d.department_id=40;
 

/*3. Write a query to display the employee last name,department name ,location id and city of all employees who earn commission.*/
select e.last_name,d.department_name,d.location_id,l.city
from employees as e join departments as d  on e.department_id=d.department_id join locations as l on d.location_id=l.location_id
where e.commission_pct != 0;

/*4. Display the employee last name and department name of all employees who have an 'a'   in their last name */
select e.last_name,d.department_name from employees as e 
inner join departments as d on e.department_id=d.department_id where e.last_name Like '%a%';

/*5. Write a query to display the last name ,job,department number and department name for all employees who work in ATLANTA. */
select e.last_name,e.job_id,d.department_id,d.department_name from
employees as e, departments as d inner join locations as l on d.location_id=l.location_id where l.city='ATLANTA';
/* There is no one working at Atlanta */

/*6. Display the employee last name and employee number along with their manager's last name and manager number.*/
select concat (e.first_name,e.last_name) as Emp_Name,e.employee_id,e.manager_id,concat (e1.first_name,e1.last_name) as Mgr_name
from employees as e join employees as e1 on 
e.manager_id=e1.employee_id where e.manager_id is not null;

/*7. Display the employee last name and employee number along with their manager's last name and manager number (including the employees who have no manager ) .*/

select concat (e.first_name,e.last_name) as Emp_Name,e.employee_id,e.manager_id,concat (e1.first_name,e1.last_name) as Mgr_name
from employees as e left join employees as e1 on 
e.manager_id=e1.employee_id ;

/*8. Create a query that displays employees last name ,department number,and all the employees who work in the same department as a given employee.*/
select e.last_name,d.department_id from employees as e 
join departments as d on e.department_id=d.department_id where d.department_id=e.department_id;

/*9. Create a query that displays the name ,job,department name ,salary,grade for all employees.
Derive grade based on salary(>=50000=A, >=30000=B,<30000=C) */
select e.first_name,j.job_title,d.department_name,e.salary,
case when salary>=50000 then 'A' when salary>=30000 then 'B' when salary<30000 then 'C' end as grade 
from jobs as j ,employees as e join departments as d on e.department_id=d.department_id;

/*10. Display the names and hire date for all employees who were hired before their managers along withe their manager names and hire date.
Label the columns as Employee name , emp_hire_date,manager name,man_hire_date */

select concat (e.first_name,e.last_name) as Emp_Name,e.hire_date,concat (e1.first_name,e1.last_name) as Mgr_name,e1.hire_date
from employees as e join employees as e1 on 
e.manager_id=e1.employee_id where e1.hire_date>e.hire_date
