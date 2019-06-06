CREATE TABLE dates1
(
[Datekey] [int] NOT NULL,
[Date] [date] NULL,
[DateText] [char](10) NULL,
[DateTextDA] [char](20) NULL,
[DateTextEN] [char](20) NULL,
[DateTextSE] [char](20) NULL,
[DateTextNO] [char](20) NULL,
[DateTextFI] [char](20) NULL,
[YearKey] [smallint] NULL,
[Year] [date] NULL,
[HalfYearOfYearKey] [tinyint] NULL,
[HalfYear] [date] NULL,
[HalfYearText] [char](5) NULL,
[HalfYearTextDA] [char](20) NULL,
[HalfYearTextEN] [char](20) NULL,
[HalfYearTextSE] [char](20) NULL,
[HalfYearTextNO] [char](20) NULL,
[HalfYearTextFI] [char](20) NULL,
[QuarterOfYearKey] [tinyint] NULL,
[Quarter] [date] NULL,
[QuarterText] [char](5) NULL,
[QuarterTextDA] [char](20) NULL,
[QuarterTextEN] [char](20) NULL,
[QuarterTextSE] [char](20) NULL,
[QuarterTextNO] [char](20) NULL,
[QuarterTextFI] [char](15) NULL,
[MonthOfYearKey] [smallint] NULL,
[Month] [date] NULL,
[MonthText] [char](5) NULL,
[MonthTextDA] [char](14) NULL,
[MonthTextEN] [char](14) NULL,
[MonthTextSE] [char](14) NULL,
[MonthTextNO] [char](14) NULL,
[MonthTextFI] [char](14) NULL,
[ISOWeek] [int] NULL,
[USWeek] [int] NULL,
[ISOWeekKey] [tinyint] NULL,
[USWeekKey] [tinyint] NULL,
[DaysInYear] [smallint] NULL,
[DaysInYearToDate] [smallint] NULL,
[DaysInHalfYear] [smallint] NULL,
[DaysInHalfYearToDate] [smallint] NULL,
[DaysInQuarter] [smallint] NULL,
[DaysInQuarterToDate] [smallint] NULL,
[DaysInMonth] [smallint] NULL,
[DaysInMonthToDate] [smallint] NULL
)

-- Stored Procedure to populate data
use T5_Padmanabh

CREATE PROCEDURE dates1 as dt
 -- Add the parameters for the stored procedure here
 @p_start_year date,
 @p_end_year date
AS
BEGIN
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;
Declare @date datetime -- DateTime
Declare @date_end datetime -- DateTime
Declare @calendar_date_id integer
Declare @date_short_name varchar(25)
Declare @date_long_name varchar(50)
Declare @day_in_week smallint
Declare @day_in_month smallint
Declare @day_in_qtr smallint
Declare @day_in_year smallint
Declare @day_of_week_abbr nvarchar(3)
Declare @week_in_year integer
Declare @week_id integer
Declare @padded_week_in_year nvarchar(2)
Declare @year integer
Declare @week_start_date date
Declare @week_end_date datetime
Declare @week_short_name varchar(25)
Declare @week_long_name varchar(50)
Declare @week_in_month smallint
Declare @week_in_qtr smallint
Declare @month_short_name nvarchar(25)
Declare @month_long_name nvarchar(50)
Declare @month_start_date datetime
Declare @half_span smallint
Declare @br_month_start_date datetime
Declare @month_end_date datetime
Declare @month_id integer
Declare @padded_month_in_year nvarchar(2)
Declare @padded_qtr_in_year nvarchar(2)
Declare @month_in_year smallint
Declare @qtr_in_year smallint
Declare @month_in_qtr smallint
Declare @month_span smallint
Declare @qtr_id integer
Declare @qtr_short_name varchar(25)
Declare @qtr_long_name varchar(50)
Declare @qtr_start_date datetime
Declare @qtr_end_date datetime
Declare @qtr_span smallint
Declare @year_short_name varchar(25)
Declare @year_long_name varchar(50)
Declare @year_start_date datetime
Declare @year_end_date datetime
Declare @year_span smallint
Declare @padded_day_in_month char(2)
Declare @date_id integer
Declare @DateTextDA char (20)
Declare @DateTextEN char (20)
Declare @DateTextSE char (20)
Declare @DateTextNO char (20)
Declare @DateTextFI char (20)
Declare @HalfyearText char (5)
Declare @HalfYearOfYearKey tinyint
Declare @HalfYear date
Declare @HalfYearStartDate Date
Declare @HalfYearEndDate Date
Declare @HalfYearSpan TinyInt
Declare @DaysInHalfYear TinyInt
Declare @QuarterOfyearKey TinyInt
Declare @Quarter Datetime
Declare @QuarterText char (5)
Declare @MonthTextDA Char(14)
Declare @MonthTextEN Char(14)
Declare @MonthTextSE Char(14)
Declare @MonthTextNO Char(14)
Declare @MonthTextFI Char(14)
declare @cntr int


set @date = cast(0 as datetime)
set @date = @p_start_year


 -- Truncate table Dimensions.Date data before inserting data
 Truncate table dates1

while @date <= @p_end_year
begin
/* Define standard calendar */
 set @date_end = dateadd(ss, -1, dateadd(d, 1, @date))
 set @day_in_week = datepart(dw, @date)
 set @day_in_month = datepart(d, @date)
 set @padded_day_in_month = right('00' + rtrim(cast(@day_in_month as char(2))), 2)
 set @qtr_start_date = dateadd(q, datediff(q, 0, @date), 0)
 set @day_in_qtr = datediff(d, @qtr_start_date, @date) + 1
 set @day_in_year = datepart(dy, @date)
 set @day_of_week_abbr = left(datename(dw, @date), 3)
 set @week_in_year = datepart(wk, @date)
 set @padded_week_in_year = right('00' + rtrim(cast(@week_in_year as char(2))), 2)
 set @year = datepart(yy, @date)
 set @week_start_date = dateadd(d, 1- @day_in_week, @date)
 --set @week_end_date = dateadd(ss, -1, dateadd(wk, 1, @week_start_date))
 set @week_end_date = dateadd(DD, -1, dateadd(wk, 1, @week_start_date))
 set @week_short_name =  @padded_week_in_year + '-' +  cast(@year as char(4))
 set @week_long_name =  @padded_week_in_year + ', ' + cast(@year as char(4))
   set @week_in_qtr = 
         CASE
              WHEN datepart(mm, @date) >=1 and datepart(mm, @date) <=3 THEN 
                   datediff(wk, cast('01/01/' + cast(datepart(yyyy, @date) as nvarchar(4)) as smalldatetime), @date) + 1
              WHEN datepart(mm, @date) >=4 and datepart(mm, @date)<=6 THEN
                datediff(wk, cast('04/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
             WHEN datepart(mm, @date)>=7 and datepart(mm, @date)<= 9 THEN
                     datediff(wk, cast('07/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                ELSE
                     datediff(wk, cast('10/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
          END 


   set @week_in_month =
           CASE
             WHEN datepart(mm, @date) = 1  THEN 
                  datediff(wk, cast('01/01/' + cast(datepart(yyyy, @date) as nvarchar(4)) as smalldatetime), @date) + 1
                 WHEN datepart(mm, @date) = 2  THEN 
                   datediff(wk, cast('02/01/' + cast(datepart(yyyy, @date) as nvarchar(4)) as smalldatetime), @date) + 1
                 WHEN datepart(mm, @date) = 3  THEN 
                   datediff(wk, cast('03/01/' + cast(datepart(yyyy, @date) as nvarchar(4)) as smalldatetime), @date) + 1
                 WHEN datepart(mm, @date) = 4 THEN
                   datediff(wk, cast('04/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 WHEN datepart(mm, @date) = 5 THEN
                   datediff(wk, cast('05/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 WHEN datepart(mm, @date) = 6 THEN
                   datediff(wk, cast('06/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 WHEN datepart(mm, @date) = 7 THEN
                    datediff(wk, cast('07/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 WHEN datepart(mm, @date) = 8 THEN
                   datediff(wk, cast('08/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 WHEN datepart(mm, @date) = 9 THEN
                   datediff(wk, cast('09/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 WHEN datepart(mm, @date) = 10 THEN
                   datediff(wk, cast('10/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 WHEN datepart(mm, @date) = 11 THEN
                   datediff(wk, cast('11/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 WHEN datepart(mm, @date) = 12 THEN
                    datediff(wk, cast('12/01/' + cast(datepart(yyyy,@date) as nvarchar(4)) as smalldatetime),@date) + 1
                 ELSE
                      0
              END 


 if left(datepart(MONTH, @date), 3) < 10
 set @month_short_name = '0'+ left(datepart(MONTH, @date), 3) + '-' + cast(@year as char(4))
 Else 
 Set @month_short_name = left(datepart(MONTH, @date), 3) + '-' + cast(@year as char(4))
 set @month_long_name = datename(m, @date) + ' ' + cast(@year as char(4))
 set @month_start_date = dateadd(m, datediff(m, 0, @date), 0)
 set @qtr_in_year = datepart(q, @date)
 set @month_in_year = datepart(m, @date)
 set @month_in_qtr = ((@month_in_year - 1) % 3) + 1
 set @month_end_date = dateadd(ss, -1, dateadd(m, 1, @month_start_date))
 set @month_span = datepart(d, @month_end_date) 
 set @padded_month_in_year = right('00' + rtrim(cast(@month_in_year as char(2))), 2)
 set @week_id = cast(@year as char(4)) + @padded_week_in_year + @padded_month_in_year
 set @month_id = cast(@year as char(4)) + @padded_month_in_year
       set @padded_qtr_in_year = right('00' + rtrim(cast(@qtr_in_year as char(2))), 2)
 set @qtr_id = cast(@year as char (4)) + @padded_qtr_in_year
 
 set @qtr_short_name = 'Q' +cast(@qtr_in_year as char(1)) + '-' + Right(@year,2) --cast(@year as char(4))
 
 set @qtr_long_name =
  case @qtr_in_year
   when 1 then '1st'
   when 2 then '2nd'
   when 3 then '3rd'
   when 4 then '4th'
  end
  + ' Quarter, ' + cast(@year as char(4))
  
  Set @QuarterText = @qtr_short_name  
  Set @QuarterOfyearKey = Case 
  when  left(@QuarterText,2) = 'Q1' then 1
  when  left(@QuarterText,2) = 'Q2' then 2
  when  left(@QuarterText,2) = 'Q3' then 3
  when  left(@QuarterText,2) = 'Q4' then 4
  END 
  
 set @qtr_end_date = dateadd(ss, -1, dateadd(q, 1, @qtr_start_date))
 set @qtr_span = datediff(d, @qtr_start_date, @qtr_end_date) + 1
 set @year_short_name = @year
 set @year_long_name = 'Year - ' + cast(@year as char(4))
 set @year_start_date = dateadd(yy, datediff(yy, 0, @date), 0)
 set @year_end_date = dateadd(DD, -1, dateadd(yy, 1, @year_start_date))
 set @year_span = datediff(d, @year_start_date, @year_end_date) + 1
 set @date_id = cast(@year as char(4)) + @padded_month_in_year + @padded_day_in_month
 set @date_short_name = @padded_day_in_month + '-' + @month_short_name
 set @date_long_name = datename(mm, @date) + ' ' + cast(@day_in_month as varchar(2)) + ', ' +          cast(@year as char(4))
 set @HalfYearOfYearKey = Case when left(@month_short_name,2) < '07' then 1 else 2 End
 SET @HalfYearStartDate = 
  CASE WHEN @HalfYearOfYearKey = 1 THEN @year_start_date ELSE DATEADD(M,6,@year_start_date) END  
 SET @HalfYearEndDate = DATEADD(d,-1,dateadd(m,6,@HalfYearStartDate))
 SET @HalfYearSpan = Datediff(D,@HalfYearStartDate,@HalfYearEndDate) +1
 SET @DaysInHalfYear = Datediff(D,@HalfYearStartDate,@date) +1
 Set @HalfYear = Case when left(@month_short_name,2) < '07' then LEFT(@year,4)+ '-01-01' else  LEFT(@year,4)+ '-07-01' End
 Set @HalfyearText = Case when left(@month_short_name,2)  < '07' then '1H-' +right(@year,2) else '2H-' + right(@year,2) End 
 SET LANGUAGE Danish
 SELECT @DateTextDA = DATEname(DAY,@date) + '. ' + DATENAME(month, @date) + ' ' + Datename(YEAR, @date)
 SELECT @MonthTextDA =  DATENAME(month, @date) + '-' + right(@year,2)
 SET LANGUAGE British
 SELECT @DatetextEN = DATEname(DAY,@date) + '  ' + DATENAME(month, @date) + ' ' + Datename(YEAR, @date)
 SELECT @MonthtextEN = DATENAME(month, @date) + '-' +right(@year,2) 
 SET LANGUAGE Swedish
 SELECT @DateTextSE = DATEname(DAY,@date) + '. ' + DATENAME(month, @date) + ' ' + Datename(YEAR, @date)
 SELECT @MonthTextSE = DATENAME(month, @date) + '-' + right(@year,2)  
 SET LANGUAGE Norwegian
 Set @DateTextNO = DATEname(DAY,@date) + '. ' + DATENAME(month, @date) + ' ' + Datename(YEAR, @date)
 Set @MonthTextNO =  DATENAME(month, @date) + '-' + right(@year,2) 
 SET LANGUAGE Finnish
 Set @DateTextFI = DATEname(DAY,@date) + '. ' + DATENAME(month, @date) + ' ' + Datename(YEAR, @date)
 Set @MonthTextFI = DATENAME(month, @date) + '-' +right(@year,2)
 
 Set language English
   Insert into dates
   Select 
   @Date_id as DateKey,
   @date as Date,
   left(@date_short_name,2)+'-'+@month_short_name AS DateText,
   --@day_in_week,
   --@day_of_week_abbr,
   @DateTextDA as DateTextDA,
   @DateTextEN as DateTextEN,
   @DateTextSE as DateTextSE,
   @DateTextNO as DateTextNO,
   @DateTextFI as DateTextFI,
   @year as YearKey,
   @Date as Year,
   @HalfYearOfYearKey,
   @HalfYear,
   @HalfyearText,
   HalfyearTextDA =  case
   when left(@HalfyearText,2) = '1H' then '1. Halvår' + '-' + right(@year,2)
   when left(@HalfyearText,2) = '2H' then '2. Halvår' + '-' + right(@year,2)
   end,
   HalfyearTextEN =  case
   when left(@HalfyearText,2) = '1H' then '1st Half-year' + '-' + right(@year,2)
   when left(@HalfyearText,2) = '2H' then '2nd Half-year' + '-' + right(@year,2)
   end,
   HalfyearTextSE =  case
   when left(@HalfyearText,2) = '1H' then '1. Halvår' + '-' + right(@year,2)
   when left(@HalfyearText,2) = '2H' then '2. Halvår' + '-' + right(@year,2)
   end,
   HalfyearTextNO =  case
   when left(@HalfyearText,2) = '1H' then '1. Halvår' + '-' + right(@year,2)
   when left(@HalfyearText,2) = '2H' then '2. Halvår' + '-' + right(@year,2)
   end,
   HalfyearTextFI =  case
   when left(@HalfyearText,2) = '1H' then '1. Puolen-vuoden' + '-' + right(@year,2)
   when left(@HalfyearText,2) = '2H' then '2. Puolen-vuoden' + '-' + right(@year,2)
         end,
    QuarterOfyearKey = Case 
   when  left(@QuarterText,2) = 'Q1' then 1
   when  left(@QuarterText,2) = 'Q2' then 2
   when  left(@QuarterText,2) = 'Q3' then 3
   when  left(@QuarterText,2) = 'Q4' then 4
        END ,
   Quarter = case
       when left(@QuarterText,2) = 'Q1' then right(@year,4) + '0101'
       when left(@QuarterText,2) = 'Q2' then right(@year,4) + '0401'
       when left(@QuarterText,2) = 'Q3' then right(@year,4) + '0701'
       when left(@QuarterText,2) = 'Q4' then right(@year,4) + '1001'
      end,
   @QuarterText,
   QuarterTextDA =  case
        when left(@QuarterText,2) = 'Q1' then '1. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q2' then '2. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q3' then '3. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q4' then '4. Kvartal' + '-' + right(@year,2)
        end,
   QuarterTextEN =  case
    when left(@QuarterText,2) = 'Q1' then '1st Quarter' + '-' + right(@year,2)
    when left(@QuarterText,2) = 'Q2' then '2nd Quarter' + '-' + right(@year,2)
    when left(@QuarterText,2) = 'Q3' then '3rd Quarter' + '-' + right(@year,2)
    when left(@QuarterText,2) = 'Q4' then '4th Quarter' + '-' + right(@year,2)
        end,
   QuarterTextSE =  case
        when left(@QuarterText,2) = 'Q1' then '1. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q2' then '2. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q3' then '3. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q4' then '4. Kvartal' + '-' + right(@year,2)
        end,
   QuarterTextNO =  case
        when left(@QuarterText,2) = 'Q1' then '1. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q2' then '2. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q3' then '3. Kvartal' + '-' + right(@year,2)
        when left(@QuarterText,2) = 'Q4' then '4. Kvartal' + '-' + right(@year,2)
        end,
   QuarterTextFI =  case
     when left(@QuarterText,2) = 'Q1' then '1. Neljännes' + '-' + right(@year,2)
     when left(@QuarterText,2) = 'Q2' then '2. Neljännes' + '-' + right(@year,2)
     when left(@QuarterText,2) = 'Q3' then '3. Neljännes' + '-' + right(@year,2)
     when left(@QuarterText,2) = 'Q4' then '4. Neljännes' + '-' + right(@year,2)
        End,
   @month_in_year,
   Month = Case 
      when left(@month_short_name,2) = '01' then right(@year,4) + '-01-01'
      when left(@month_short_name,2) = '02' then right(@year,4) + '-02-01'
      when left(@month_short_name,2) = '03' then right(@year,4) + '-03-01'
      when left(@month_short_name,2) = '04' then right(@year,4) + '-04-01'
      when left(@month_short_name,2) = '05' then right(@year,4) + '-05-01'
      when left(@month_short_name,2) = '06' then right(@year,4) + '-06-01'
      when left(@month_short_name,2) = '07' then right(@year,4) + '-07-01'
      when left(@month_short_name,2) = '08' then right(@year,4) + '-08-01'
      when left(@month_short_name,2) = '09' then right(@year,4) + '-09-01'
      when left(@month_short_name,2) = '10' then right(@year,4) + '-10-01'
      when left(@month_short_name,2) = '11' then right(@year,4) + '-11-01'
      when left(@month_short_name,2) = '12' then right(@year,4) + '-12-01'
     end,
    MonthText = left(@month_short_name,2)+'-'+right(@year,2),
   @MonthTextDA,
   @MonthTextEN,
   @MonthTextSE,
   @MonthTextNO,
   @MonthTextFI,
   ISOWeek = right(@year,4)+left(@month_short_name,2),
   USWeek = right(@year,4)+left(@month_short_name,2),
   ISOWeekKey = DATEPART(ISO_WEEK, @date),
   USWeekKey = DATEPART(WW, @date),
   @year_span as DaysInYear,
   @day_in_year as DaysInYearToDate,   
   @HalfYearSpan,   
   @DaysInHalfYear,
   @qtr_span as DaysInQuarter, 
   @day_in_qtr as DaysInQuarterToDate,
   @month_span as DaysInMonth,
   @day_in_month as DaysInMonthToDate      
  set @date = dateadd(d, 1, @date)
end
END