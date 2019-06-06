-- TSQL Excerise 2-T_SQL_Exercise 
--Procedures
--1. write a procedure to count the no of weekdays in a year
use Northwind
use T5_Padmanabh
alter proc weekdays (@week_st_dt datetime,@week_end_st datetime)
as 
begin 
	declare @count int =0 
	if @week_end_st=NULL
		set @week_end_st=EOMONTH(@week_st_dt) -- last day of month
	while datediff (dd,@week_st_dt,@week_end_st)>=0 
	begin
		if DATENAME(dw,@week_st_dt) <> 'Saturday'
			and DATENAME(dw,@week_st_dt) <> 'Sunday'
			and not ((day(@week_st_dt)=1 and MONTH (@week_st_dt) =1 )) -- New years date
			and not ((day(@week_st_dt)=4 and MONTH (@week_st_dt) =7 )) -- Independance days 
		
	set @count =@count + 1
	end

	set @week_st_dt=DATEADD(dd,1,@week_st_dt)
return --cast (@count as varchar(20))
end

exec weekdays '21-04-2019','29-04-2019'

/*
declare @y int = 2019
declare @d datetime = dateadd(year, @y - 1900, 0)

;with cte
as
(
    select 1 a, 
      left(datename(weekday, @d), 3) b,
      datename(month, 0) Month,
      1 sort
    union all
    select a + 1 a, 
      left(datename(weekday, @d + a), 3) b, 
      datename(month, @d + a) Month, 
      datepart(month, @d + a) sort
    from cte where a < datepart(dayofyear, dateadd(year, 1, @d)-1)
)
select month, [Mon],[Tue],[Wed],[Thu],[Fri],[Sat],[Sun], 
     [Mon]+[Tue]+[Wed]+[Thu]+[Fri]+[Sat]+[Sun] [Sum] 
from cte
pivot (count(a) FOR [b] IN ([Mon],[Tue],[Wed],[Thu],[Fri],[Sat],[Sun],[Sum])) AS pvt
order by sort 
option (maxrecursion 366)*/
