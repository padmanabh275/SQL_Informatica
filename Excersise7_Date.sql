use T5_Padmanabh;

/* Date Excersise */

/* Find the date difference between hire_date and resignation_date for all the employees.
display no. of days,months and year (1 year 3 months 5 days */

create table Emp_Data
(
Emp_ID int,
Hire_date datetime,
Resignation_Date datetime,
)
select * from Emp_Data;

declare @dateofbirth datetime
declare @currentdatetime datetime
declare @years varchar(40)
declare @months varchar(40)
declare @days varchar(30)

set @dateofbirth='1986-03-15' --birthdate

set @currentdatetime = getdate()-- current datetime

select @years= datediff (year,@dateofbirth,@currentdatetime) -- To find Years


select @months=datediff(month,@dateofbirth,@currentdatetime)-(datediff(year,@dateofbirth,@currentdatetime)*12) -- To Find Months

select @days=datepart(d,@currentdatetime)-datepart(d,@dateofbirth)-- To Find Days

select @years  +' years,   ' +@months +' months,   '+@days   +' days' asYearMonthDay


select Emp_ID,
datediff(year,Hire_date,Resignation_Date) as years,(datediff(month,Hire_date,Resignation_Date)%365/30) as months,
(datediff(day,Hire_date,Resignation_Date)%365%30) as day_s
from Emp_Data;

SELECT GETDATE()

/*2 Format the hire_date as mm/dd/yyyy(09/22/2003) and resignation date as mon dd,yyyy	(Aug 12,2004)
display the null as (dec,01,1900) */

select * from Emp_Data;
select Emp_ID,convert (varchar(40),Hire_date,101) as New_hire_Dt,
case 
when Resignation_Date is not null then convert(varchar(40),Resignation_Date,107)
when Resignation_Date is null then 'dec 01,1900'
end as New_Format	
from Emp_Data;

select Emp_ID, CONVERT(varchar(40),Hire_date,101) as New_Hire_Dt
if (Resignation_Date) is not null
	convert(varchar(40),Resignation_Date,107),
else 'dec 01,1900'
from Emp_Data



/*3 Calculate Expereince of the employee till date in Years and months (eg. 1 year 3 months) */

select Emp_ID,concat(coalesce(datediff(year,Resignation_Date,getdate()),0),' ','years(s)',
abs(coalesce(datediff(day,month(Resignation_Date),month(getdate())),0)),' ','months(s)') as Experience
from Emp_Data

/*4 Display the count of days in the previous quarter */
select * from Emp_Data;

select  datediff(day,dateadd(qq,-1,getdate()),getdate())

select (DATEDIFF(day, GETDATE(), DATEADD(quarter, DATEDIFF(quarter, -1, (GETDATE())), 0))) 



/*5 Fetch the previous quarters second week's first day date */
--start date of current week 

-- previous quarter

select dateadd(week,1,dateadd(quarter,datediff(quarter,0,getdate())-1,0))


select dateadd(week,-2,getdate())
select datediff(quarter,0,getdate())
select ((dateadd(quarter,-1,getdate()))+8)


/*6 Fetch the Financials year 15th week dates (format:mon dd yyyy) */

select (dateadd (week,1,convert (varchar(40),getdate(),110))-105)

/*7 Find out the last date that corresponds to the last Saturday to January,2015 using with clause */

select eomonth (getdate())


use airport;
/* 8 using airport database find the no of days elapsed between first and last flights of a passenger */
select * from company
select * from pass_in_trip
select * from passenger
select * from trip

select distinct Passenger.name, concat('',(datepart(dd,pass.date)-datepart(dd,trip.time_out))) as No_of_Days
from trip as trip
join pass_in_trip as pass on 
trip.trip_no=pass.trip_no
join passenger as passenger on 
pass.ID_psg=passenger.ID_psg

/*9 find the total duration in minutes and in seconds of the flight from Rostov to Moscow*/

select trip.plane,trip.town_from,trip.town_to,--CONCAT((DATEDIFF(Minute,trip.time_in,trip.time_out)/60),':',
       concat ((DATEDIFF(Minute,trip.time_out,trip.time_in)%60),
	   ':',
	   (DATEDIFF(second,trip.time_out,trip.time_in))) as Total_Minutes_Seconds
--datepart(hh,trip.time_out),datepart(hh,trip.time_in)
from trip as trip
join pass_in_trip as pass on 
trip.trip_no=pass.trip_no
join passenger as passenger on 
pass.ID_psg=passenger.ID_psg
where trip.town_from='Rostov' and trip.town_to='Moscow'


