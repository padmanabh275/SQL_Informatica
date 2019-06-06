use T5_padmanabh
CREATE TABLE dates
(
    [DateID] INT , 
    [Date_desc] DATETIME,
	[Week_ID] int,
	[Week_desc] varchar(2),
	[Month_ID] int,
	[Month_desc] varchar(2),
	[Qtr_ID] int,
	[Qtr_Desc] varchar(2),
	[Year_ID] int,
	[Year_Desc] varchar(2),
	[Week_Day] varchar(15),
	[Holiday_Flag] varchar(1),
	[Week_Start_Date] date,
	[Month_Start_Date] date,
	[Qtr_Start_Date] date,
	[Year_Start_Date] date,
	[Day_of_the_Week] varchar(2),
	[Day_of_the_Month] varchar(2),
	[Day_of_the_Qtr] varchar(3),
	[Day_of_the_Year] varchar(3),
	[Leap_Year_Flag] varchar(1),
	[Date_IND_Format] date,
	[Date_US_Format] date,
	[Date_UTC_Format] date,
)



alter proc storing (@startdate date,@enddate date)
as
begin 


	--set nocount on
	--set @startdate= ('27/04/2019')
	--set @enddate= ('27/04/2020')

while @startdate <= @enddate
begin
	alter table dates alter column Date_Desc date 
	alter table dates alter column Week_Desc varchar(10) 
	alter table dates alter column Month_Desc varchar(10) 
	alter table dates alter column Week_Start_Date varchar(10) 
	alter table dates alter column Year_Desc varchar(10) 
	alter table dates alter column Month_Start_Date varchar(10) 
	alter table dates alter column Qtr_Start_Date date
	declare @dateid int 
	declare @date date
	declare @date_desc varchar(20)
	declare @weekid varchar(10)
	declare @week_desc varchar(10)
	declare @monthid int,@month_desc varchar(10)
	declare @Qtrid int,@Qtr_desc varchar(10)
	declare @yearid int,@year_desc varchar(10)
	declare @weekday varchar(10)
	declare @holiday varchar(10)
	declare @weekstart varchar(10)
	declare @monthst varchar(10)
	declare @qtrst date
	declare @yearst date,@dayweek int,@dayofmonth int
	declare @dayofqtr varchar(10),@dayofyear varchar(10)
	declare @leapyear char(5)
	declare	@indformat date ,@usformat date,@utcformat date

	set @dateid=cast(convert(varchar(10),@startdate,112) as int)
	set @date_desc=convert(varchar,@startdate,111)
	set @weekid=datepart(week,@startdate)
	set @week_desc=concat('w',datepart(week,@startdate))	
	set @monthid=datepart(month,@startdate)
	set @month_desc=concat('m',datepart(month,@startdate))
	set @Qtrid= datepart(qq,@startdate)
	set @Qtr_desc=concat('q',datepart(qq,@startdate))
	set @yearid=datepart(year,@startdate)
	set @year_desc=concat('y',datepart(year,@startdate))
	set @weekday=datename(dw,@startdate)
	set @holiday = (select case when datename(dw,@startdate)='Saturday' or datename(dw,@startdate)='Sunday' then 'Y' else 'N' end )
	set @weekstart=dateadd(dd,datepart(dw, @startdate), @startdate)
	set @monthst=dateadd(dd,1,(eomonth(@startdate,-1))) 
	set @qtrst=dateadd(quarter, datediff(quarter, 0, @startdate),0)
	set @yearst= dateadd(yy, datediff(yy, 0, @startdate), 0)
	set @dayweek=datepart (dw,@startdate)
	set @dayofmonth=datepart (month,@startdate)
	set @dayofqtr=(datediff(day,dateadd(qq, datediff(qq, 0, @startdate),0),@startdate)+1)
	set @dayofyear=datepart(dayofyear,@startdate)
	set @leapyear=(select case when(year(@startdate) % 4=0 and year(@startdate) % 100 <> 0) or year(@startdate) % 400 =0 then 'Y' else 'N' end)
	set @indformat=(select format(@startdate,'d','en-in'))
	set @usformat=(select format (@startdate,'d','en-us'))
	--set @utcformat=(select getutcdate())
		set language english 
		insert into dates (DateID,Date_desc,Week_ID,Week_Desc,Month_ID,Month_Desc,Qtr_ID,Qtr_Desc,Year_ID,
							Year_Desc,Week_Day,Holiday_Flag,Week_Start_Date,Month_Start_Date,Qtr_Start_Date,
							Year_Start_Date,Day_of_the_Week,Day_of_the_Month,Day_of_the_Qtr,Day_of_the_Year,
							Leap_Year_Flag,Date_IND_Format,Date_US_Format)--,Date_UTC_Format)
																				
		values (@dateid,@date_desc,@weekid,@week_desc,@monthid,@month_desc,@Qtrid,@Qtr_desc,@yearid,@year_desc,
				@weekday,@holiday,@weekstart,@monthst,@qtrst,@yearst,@dayweek,@dayofmonth,@dayofqtr,@dayofyear,
				@leapyear,@indformat,@usformat)--,@utcformat)
		--select 
		--	@date as Date_Desc
		set @startdate = dateadd(dd, 1,@startdate)
		end
end 
select dateadd(dd,1,getdate())
exec storing '2019-05-01','2019-06-21'	
 
truncate table dates
select @startdate as getutcdate()