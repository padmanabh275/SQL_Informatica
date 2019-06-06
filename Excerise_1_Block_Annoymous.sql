--TSQL - Excerise 1 
-- display total no of employees in employees table using anonymous block 
use HR,
begin
select count(employee_id) from employees
end
-- Create an annoymous block to display factorial of a no. 
use T5_Padmanabh
alter function dbo.fact(@input int)
returns int 
as
begin 
declare @no int
 if @input<=1
	set @no=1
 else 
	set @no=@input * dbo.fact(@input -1)
return (@no)
end 
select dbo.fact(4)

-- create an annoytmous block to display the months in a year 

begin
select datename(month,dateadd(mm,s.number,convert(datetime,0))) as [monthname],
month(dateadd(mm,s.number,convert(datetime,0))) as [monthnumber]
from master.dbo.spt_values s where [type] ='P' and s.number
between 0 and 11 
order by 2
end

-- create pl/sql block to accept a year and check wheather it is leap year or not 
declare @date1 varchar(20),@date2 varchar(20)
begin
set @date1=getdate()
set @date2= case when(year(@date1) % 4=0 and year(@date1) % 100 <> 0) or year(@date1) % 400 =0 then 'Yes a Leap Year' else 'No Leap Year' end
--return(@date2)
end


alter function leap(@date datetime)
returns varchar(20)
as 
begin 
declare @date1 varchar(20),@date2 varchar(20)
set @date1=@date
set @date2= case when(year(@date1) % 4=0 and year(@date1) % 100 <> 0) or year(@date1) % 400 =0 then 'Yes a Leap Year' else 'No Leap Year' end
return(@date2)
end
select dbo.leap(29-04-2024)

-- pl/sql block to accept a string and count the vowels in the string 

declare @input varchar(20), @string int, @count int,@len int,@char char,@string2 int
begin 
set @count=0
set @input=('aafrwwrer')
while (@count<@len)
begin
set @char=substring(@input,@count,1)
	if @char in ('A','E','I','O','U') or @char in ('a','e','i','o','u') 
		set @string=@string +1
	--else
		--if @char not in (' ')
		--set	@string2=@string2+1
set @count=@count+1
end 
end

set serveroutput on 
declare 
v_message varchar2(255):='Hello World!';
begin 
dbms_output.pitline (I_message);
end




alter function vowels(@input varchar)
returns int
as 
begin 
declare @string int, @count int,@len int,@char char
set @len=len(@input)
set @count=0
while (@count<=@len)
begin
	set @char=substring(@input,@count,1)
	if @char in ('A','E','I','O','U') or @char in ('a','e','i','o','u') 
		set @string=@string +1
--	else
	--	if @char not in (' ')
	--	set	@string2=@string2+1
set @count=@count+1
end 
return @string
end

select dbo.vowels('asasd23dfd1awe')

