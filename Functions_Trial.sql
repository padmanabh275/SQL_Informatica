use T5_Padmanabh;
use hr;
select * from employees;


create function Mgr_name (@employee_id int)
returns int 
as
begin 
declare @Mgr_id int;
select  @Mgr_id= manager_id from hr.employees
where employee_id=@employee_id;
return @Mgr_id
end

select T5_Padmanabh.Mgr_name(employee_id) from hr.employees;
use hr;
select * from employees;
use T5_Padmanabh;

alter function Mgr_name2 (@emp1 int)
returns varchar(20)
as 
begin 
declare @emp varchar(20);
select @emp= first_name
from hr.dbo.employees
where employee_id = (select manager_id from hr.dbo.employees where employee_id=@emp1)
return case when @emp is null then 'No manager'else @emp end;
end
use hr;
select * from employees
select dbo.Mgr_name2(154)

select dbo.hr.Mgr_name2(101);
use T5_Padmanabh;
alter function Manager6 (@manager_id int)
returns varchar(20)
as 
begin 
declare @manager_id1 varchar(20)
select @manager_id1 = emp1.first_name+emp1.last_name 
from hr.dbo.employees as emp
join hr.dbo.employees as emp1 
on emp.manager_id=emp1.employee_id
where emp.employee_id=@manager_id
return @manager_id1 
end

select dbo.Manager6(110);
select * from hr.dbo.employees;