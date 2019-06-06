/* TSQL - Excerise 2 - Functions */

use HR;

/*1 Create a function which would get employee_id as input and return the manager name . if he has no manager, then 
the function should return 'No Manager'*/

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
use T5_Padmanabh

select dbo.Mgr_name2(115)
	

/*2 Create a table-valued function which takes a string	as a parameter and it should return the characters 
and its contribution to the input string */

alter function timepass(@inputstring varchar(50))
returns @contribute table
(
characters varchar(1),
contribution float
)
as 
begin
declare @length int,@count int,@percent float,@string int;
set @length=len(@inputstring)
set @percent=100/@length
set @count=1
set @string=@length
while (@count<=@length)
begin
insert into @contribute 
select substring(@inputstring,@count,1),(@percent *(len(@inputstring)-len(replace(@inputstring,substring(@inputstring,@count,1),''))))
where substring(@inputstring,@count,1) not in (select characters from @contribute)
set @count = @count +1
end
--delete from @contribute where characters in (select  characters from @contribute group by characters having count(*)>1)
	--if @inputstring=@contribute 
	--insert into @contribute 

return
end
use T5_Padmanabh
select 'PADDY' from timepass
select * from dbo.timepass('padnanabh')

select * from information_schema.routines 


/* Create 3 udf - a) To seperate the nos from the input string and return the sum 'asdas' 5
b) To seperate the characters from the input string and return a string "das1sd%" output dassd
c)  To seperate special charcters from input string and retrun a string 'a1b2c34$' output '$#' */

use T5_Padmanabh
/*alter function ques3a(@inputstring varchar(30))
returns varchar(30)
as 
begin 
DECLARE @intAlpha INT, @total int,@total_sum int
SET @intAlpha = PATINDEX('%[^0-9]%', @inputstring)
BEGIN
WHILE @intAlpha > 0
BEGIN
SET @inputstring = STUFF(@inputstring, @intAlpha, 1, '' )
SET @intAlpha = PATINDEX('%[^0-9]%', @inputstring )
set @total=cast(@intAlpha as int)
set @total_sum=sum(@total+@total)
END
END
RETURN ISNULL(@inputstring,0)
return @total_sum
END
select dbo.ques3a('d22fsasd32') */


alter function sumofnumbers(@inputstring varchar(50))
returns int
as
begin 
declare @length int,@count int,@sumofno int
set @length=len(@inputstring)
set @count=1
set @sumofno=0
while (@count<@length)
begin
set @sumofno=@sumofno + (select substring(@inputstring,@count,1) 
where substring(@inputstring,@count,1) between 0 and 9)
set @count=@count +1
end
return @sumofno
end 

select dbo.sumofnumbers('23hjh232')

alter function stringconcat(@inputstring varchar(50))
returns varchar(50)
as 
begin 
declare @length int,@count int,@sumofno varchar(50);
set @length=len(@inputstring)
set @count=1
set @sumofno=0
while (@count<@length)
begin 
set @sumofno=@sumofno + (select substring(@inputstring,@count,1) 
where lower(substring(@inputstring,@count,1)) between 'a' and 'z')
set @count = @count + 1
end
return @sumofno
end

select dbo.stringconcat ('asdasdsad')

create function specialchar(@inputstring varchar(50))
returns varchar(50)
as
begin 
declare @length int, @count int, @sumofno varchar(50);
set @length=len(@inputstring)
set @count=1
set @sumofno=0
while (@count<@length)
begin
set @sumofno =@sumofno + (select substring(@inputstring,@count,1)
where lower(substring(@inputstring,@count,1)) not like '%[^a-zA-Z0-9]%')
set @count = @count + 1
end 
return @sumofno
end

select dbo.specialchar ('Aa2dsd@fdf@f')



/* 4 create a udf to find the retirement date of the employee by getting joining date and dob as input parameters
let the retirement age be 58 */

create function retirementdate(@joiningdt date,@dateofbirth date)
returns date
as
begin 
return select dateadd(year,58,@dateofbirth) as Dt
end

create function initcap(@inputstring varchar(300))
returns varchar(300)
as
begin
declare @index int,@Char char (1),@prevchar char(1),@outstring varchar(300);
set @outstring=lower(@inputstring)
set @index=1
while @index <= len(@inputstring)
begin 
set @char= substring(@inputstring,@index,1)
set @prevchar=case when @index=1 then '' 
else 
substring(@inputstring,@index-1,1)
end
if @prevchar in ('',';',':','!','?','"','.','-','/','&')
begin 
	if @prevchar != '' or upper(@char) != 'S'
	set @outstring=stuff(@outstring,@index,1,upper(@char))
	end
	set @index = @index +1
end
return @outstring 
end

select dbo.initcap ('fdasas sADdsfd')



-- Leap Year test
/*CASE WHEN (my_year %400) = 0 THEN 'Yes' 
WHEN MOD(my_year % 100) = 0 THEN 'No' 
ELSE CASE WHEN MOD(my_year % 4) = 0 
     THEN 'Yes' ELSE 'No 'END ; 
  END; */


