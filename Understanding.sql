
-- Name of Days, Months
SELECT 
DATENAME(WEEKDAY, GETDATE()) AS [DayName]
,DATENAME(MONTH, GETDATE()) AS [MonthName]
,DATEPART(WEEK, GETDATE()) AS [WeekNumber]
,DATEPART(ISO_WEEK, GETDATE()) AS [ISO_WeekNumber]

-- Using Date format or FORMAT or CAST / CONVERT
SELECT
CAST(GETDATE() AS DATE) AS Date_RightNow
,FORMAT(GETDATE(), 'dd/MM/yyyy') AS DATE_dd_MM_yyyy
,FORMAT(GETDATE(), 'yyyy-MM-dd') AS DATE_yyyy_MM_dd
,FORMAT(GETDATE(), 'MM-dd') AS DATE_MM_dd
,FORMAT(GETDATE(), 'dd/MM/yyyy', 'en-US' ) AS DATE_US 
,FORMAT(GETDATE(), 'dd/MM/yyyy', 'sl-SI' ) AS DATE_SLO


-- Weeks
SELECT
DATEADD(WEEK,DATEDIFF(WEEK,7,GETDATE()),0) AS LastWeek_startOf
,DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0) AS ThisWeek_startOf
,DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),7) AS NextWeek_startOf

select dateadd(week,datediff(week,7,getdate()),0)

-- Months (works for all months; with 30 or 31 days, or with February)
SELECT
DATEADD(MONTH,DATEDIFF(MONTH,31,GETDATE()),0) AS LastMonth_startOf
,DATEADD(MONTH,DATEDIFF(MONTH,0,GETDATE()),0) AS ThisMonth_startOf
,DATEADD(MONTH,DATEDIFF(MONTH,-1,GETDATE()),0) AS NextMonth_startOf

SELECT 
EOMONTH(GETDATE()) AS CurrentMonthEnd
,EOMONTH(GETDATE(), -1) AS PreviousMonthEnd
,EOMONTH(GETDATE(), 1) AS NextMonthEnd

-- Years (works with leap years)
SELECT
DATEADD(year, DATEDIFF(year, 365, (GETDATE())), 0) AS LastYear_startOf
,DATEADD(year, DATEDIFF(year, 0, (GETDATE())), 0) AS ThisYear_startOf
,DATEADD(year, DATEDIFF(year, -1, (GETDATE())), 0) AS NextYear_startOf

SELECT
DATEADD(MONTH, DATEDIFF(MONTH, -1, (GETDATE())), DAY(GETDATE()-1)) AS OneMonthFromNow
,CAST(DATEADD(MONTH, 1, CAST(GETDATE() AS DATE)) AS DATETIME) AS OneMonthFromNow


SELECT
CAST(DATEADD(YEAR, 1, CAST(GETDATE() AS DATE)) AS DATETIME) AS OneYearFromNow
,DATEADD(DAY, DATEDIFF(DAY, 0, (GETDATE())), 365) AS OneYearFromNow

-- Number of days until ...
SELECT
	 (DATEDIFF(DAY, GETDATE(), DATEADD(MONTH, DATEDIFF(MONTH, -1, (GETDATE())), 0)))-1 AS NumberOfDAysUntilEndOfMonth
	,(DATEDIFF(DAY, GETDATE(), DATEADD(YEAR, DATEDIFF(YEAR, -1, (GETDATE())), 0)))-1 AS NumberOfDAysUntilEndOfYear