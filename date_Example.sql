SET DATEFIRST 1

GO

 

DECLARE @Holiday TABLE

       (

       [Date]                     DATE,

       HolidayName                VARCHAR(50)

       )

 

--Data Source https://www.gov.uk/bank-holidays (as on 2014-01-07), Only England and Wales holidays are considered

--

INSERT INTO @Holiday([Date], HolidayName)

VALUES('2012-01-02', 'New Year''s Day(substitute day)'),

       ('2012-04-06', 'Good Friday'),

       ('2012-04-09', 'Easter Monday'),

       ('2012-05-07', 'Early May bank holiday'),

       ('2012-06-04', 'Spring bank holiday (substitute day)'),

       ('2012-06-05', 'Queen''s Diamond Jubilee (extra bank holiday)'),

       ('2012-08-27', 'Summer bank holiday'),

       ('2012-12-25', 'Christmas Day'),

       ('2012-12-26', 'Boxing Day'),

 

       ('2013-01-01', 'New Year''s Day'),

       ('2013-03-29', 'Good Friday'),

       ('2013-04-01', 'Easter Monday'),

       ('2013-05-06', 'Early May bank holiday'),

       ('2013-05-27', 'Spring bank holiday'),

       ('2013-08-26', 'Summer bank holiday'),

       ('2013-12-25', 'Christmas Day'),

       ('2013-12-26', 'Boxing Day'),

 

       ('2014-01-01', 'New Year''s Day'),

       ('2014-04-18', 'Good Friday'),

       ('2014-04-21', 'Easter Monday'),

       ('2014-05-05', 'Early May bank holiday'),

       ('2014-05-26', 'Spring bank holiday'),

       ('2014-08-25', 'Summer bank holiday'),

       ('2014-12-25', 'Christmas Day'),

       ('2014-12-26', 'Boxing Day'),

 

       ('2015-01-01', 'New Year''s Day'),

       ('2015-04-03', 'Good Friday'),

       ('2015-04-06', 'Easter Monday'),

       ('2015-05-04', 'Early May bank holiday'),

       ('2015-05-25', 'Spring bank holiday'),

       ('2015-08-31', 'Summer bank holiday'),

       ('2015-12-25', 'Christmas Day'),

       ('2015-12-28', 'Boxing Day (substitute day)')

 

DECLARE @DimDate TABLE

       (     

              DateKey                           INT PRIMARY KEY,  -- Integer date key is created as YYYYMMDD

              [Date]                     DATE, -- Actual date value

 

              [DayOfMonth]               VARCHAR(2), -- Day number of month

              DayOfMonthWithSuffix VARCHAR(4), -- Apply suffix as 1st, 2nd ,3rd etc

             

              DayOfQuarter               VARCHAR(2), -- Day number of quarter

              DayOfQuarterWithSuffix     VARCHAR(4), -- Apply suffix as 1st, 2nd ,3rd etc

              MonthOfQuarter                    VARCHAR(1), -- Month number of quarter

 

              [DayName]                  VARCHAR(9), -- Name of the day, Sunday, Monday

              DayOfWeekInMonth     VARCHAR(15), --1st Monday, 2nd Monday etc in Month

              WeekOfMonth                VARCHAR(1), -- Week Number of Month

              WeekOfQuarter        VARCHAR(2), -- Week Number of the Quarter

              [MonthName]                VARCHAR(9), -- January, February etc

              MonthYear                  CHAR(10), -- Jan-2014, Feb-2014 etc

              MMYYYY                     CHAR(6),            

              FirstDayOfMonth            DATE, -- Date for first day of month

              LastDayOfMonth             DATE, -- Date for last day of month

              FirstDayOfQuarter    DATE, -- Date for first day of quarter

              LastDayOfQuarter     DATE, -- Date for last day of quarter

             

              FullDate                   CHAR(10), -- Date in dd-MM-yyyy format

              [DayOfWeek]                CHAR(1), -- First Day Monday=1 and Sunday=7

 

              --Calender

              DayOfCalenderYear    VARCHAR(3), -- Day number in calender year

              WeekOfCalenderYear   VARCHAR(2), -- Week Number of the calender Year

              CalenderMonth        VARCHAR(2), -- Number of the Month 1 to 12

              CalenderQuarter            CHAR(1), -- Calender quarter number Jan-Mar = 1, Apr-Jun=2, Jul-Sep = 3 and Oct-Dec = 4

              CalenderYear         CHAR(4), -- Year value of Date stored as YYYY

 

              --Financial

              DayOfFinancialYear   VARCHAR(3), -- Day number in financial year

              WeekOfFinancialYear  VARCHAR(2), -- Week Number of the financial Year

              FinancialMonth             VARCHAR(2), -- Month number in financial year being Apr=1 and Mar=12

              FinancialQuarter     CHAR(1), -- Calender quarter number Apr-Jun = 1, Jul-Sep = 2, Oct-Dec = 3 and Jan-Mar = 4

              FinancialYear        CHAR(9), -- Year value of Date stored as YYYY/YYYY

                          

              [IsWeekday]                BIT, -- 0=Week End ,1=Week Day

              IsHoliday                  BIT, -- Flag 1=National Holiday, 0=No National Holiday

              HolidayName                VARCHAR(50) -- Name of Holiday in UK

       )

 

 

DECLARE @year        INT,

       @startDate           DATE,

       @endDate             DATE,

       @currentDate  DATE,

 

       @DateKey                   INT,

       @Date                      DATETIME,

 

       @DayOfMonth                       VARCHAR(2),

       @DayOfMonthWithSuffix      VARCHAR(4),

      

       @DayOfQuarter              VARCHAR(2),

       @DayOfQuarterWithSuffix    VARCHAR(4),

       @MonthOfQuarter                   VARCHAR(1),

 

       @DayName                   VARCHAR(9),

       @DayOfWeekInMonth    VARCHAR(15),

       @WeekOfMonth         VARCHAR(1),

       @WeekOfQuarter             VARCHAR(2),

       @MonthName                 VARCHAR(9),

       @MonthYear                 CHAR(10),

       @MMYYYY                           CHAR(6),            

       @FirstDayOfMonth     DATE,

       @LastDayOfMonth            DATE,

       @FirstDayOfQuarter   DATE,

       @LastDayOfQuarter    DATE,

 

       @FullDate                  CHAR(10),

       @DayOfWeek                 CHAR(1),

             

       @DayOfCalenderYear         VARCHAR(3),

       @WeekOfCalenderYear        VARCHAR(2),

       @CalenderMonth                    VARCHAR(2),

       @CalenderQuarter           CHAR(1),

       @CalenderYear              CHAR(4),

             

       @DayOfFinancialYear        VARCHAR(3),

       @WeekOfFinancialYear VARCHAR(2),

       @FinancialMonth                   VARCHAR(2),

       @FinancialQuarter          CHAR(1),

       @FinancialYear                    CHAR(9),

      

       @IsWeekday           BIT,

       @IsHoliday           BIT,

       @HolidayName  VARCHAR(50)

 

SET @startDate             = '2014-01-01'

SET @endDate         = '2014-12-31'

 

SET @currentDate     = @startDate

WHILE @currentDate<=@endDate

BEGIN

      

       SET @DateKey = CAST(CONVERT(VARCHAR, @currentDate, 112) AS INT)

       SET @Date = @currentDate

 

       SET @DayOfMonth = CASE WHEN DAY(@currentDate) <= 9 THEN '0' + CAST(DAY(@currentDate) AS VARCHAR) ELSE CAST(DAY(@currentDate) AS VARCHAR) END

       SET @DayOfMonthWithSuffix = CASE WHEN DAY(@currentDate) IN (1, 21, 31) THEN CAST(DAY(@currentDate) AS VARCHAR) + 'st'

                                                              WHEN DAY(@currentDate) IN (2, 22) THEN CAST(DAY(@currentDate) AS VARCHAR) + 'nd'

                                                              WHEN DAY(@currentDate) IN (3, 23) THEN CAST(DAY(@currentDate) AS VARCHAR) + 'rd'

                                                              ELSE CAST(DAY(@currentDate) AS VARCHAR) + 'th'

                                                       END

 

       SET @DayOfQuarter = CASE WHEN MONTH(@currentDate) IN (1, 2, 3) THEN DATEDIFF(D, CAST(YEAR(@currentDate) AS VARCHAR) + '-01-01', @currentDate) + 1

                                                WHEN MONTH(@currentDate) IN (4, 5, 6) THEN DATEDIFF(D, CAST(YEAR(@currentDate) AS VARCHAR) + '-04-01', @currentDate) + 1

                                                WHEN MONTH(@currentDate) IN (7, 8, 9) THEN DATEDIFF(D, CAST(YEAR(@currentDate) AS VARCHAR) + '-07-01', @currentDate) + 1

                                                WHEN MONTH(@currentDate) IN (10, 11, 12) THEN DATEDIFF(D, CAST(YEAR(@currentDate) AS VARCHAR) + '-10-01', @currentDate) + 1

                                         END

      

       SET @DayOfQuarterWithSuffix = CASE WHEN @DayOfQuarter IN (1, 21, 31, 41, 51, 61, 71, 81, 91) THEN CAST(@DayOfQuarter AS VARCHAR) + 'st'

                                                              WHEN @DayOfQuarter IN (2, 22, 32, 42, 52, 62, 72, 82, 92) THEN CAST(@DayOfQuarter AS VARCHAR) + 'nd'

                                                              WHEN @DayOfQuarter IN (3, 23, 33, 43, 53, 63, 73, 83, 93) THEN CAST(@DayOfQuarter AS VARCHAR) + 'rd'

                                                              ELSE CAST(@DayOfQuarter AS VARCHAR) + 'th'

                                                       END

      

       SET @DayOfQuarter = CASE WHEN CAST(@DayOfQuarter AS INT) <= 9 THEN '0' + CAST(CAST(@DayOfQuarter AS INT) AS VARCHAR) ELSE @DayOfQuarter END

 

       SET @MonthOfQuarter  = CASE WHEN MONTH(@currentDate)%3 = 0 THEN 3 ELSE MONTH(@currentDate)%3 END

      

       SET @DayName = DATENAME(DW, @CurrentDate)

 

       DECLARE @FirstDayNameOfTheMonth   VARCHAR(9),

              @DayInWeekKey                     INT

             

       SET @FirstDayOfMonth = CAST(YEAR(@currentDate) AS VARCHAR) + '-' + CAST(MONTH(@currentDate) AS VARCHAR) + '-01'

       SET @FirstDayNameOfTheMonth = DATENAME(DW, @FirstDayNameOfTheMonth)

       SET @DayInWeekKey = DATEPART(dw, @FirstDayOfMonth)

      

       SET @WeekOfMonth = CASE WHEN DATENAME(DW, @FirstDayOfMonth) = 'Monday' THEN (DAY(@CurrentDate)-1)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfMonth) = 'Tuesday' THEN (DAY(@CurrentDate))/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfMonth) = 'Wednesday' THEN (DAY(@CurrentDate)+1)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfMonth) = 'Thursday' THEN (DAY(@CurrentDate)+2)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfMonth) = 'Friday' THEN (DAY(@CurrentDate)+3)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfMonth) = 'Saturday' THEN (DAY(@CurrentDate)+4)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfMonth) = 'Sunday' THEN (DAY(@CurrentDate)+5)/7 + 1

                                         END

      

 

       SET @MonthName = DATENAME(MM, @CurrentDate)

       SET @MonthYear = SUBSTRING(DATENAME(MM, @CurrentDate), 1, 3) + '-' + CAST(YEAR(@currentDate) AS VARCHAR)

       SET @MMYYYY = SUBSTRING(CONVERT(VARCHAR, @currentDate, 112), 1, 6)

 

       SET @LastDayOfMonth = DATEADD(D,-1, DATEADD(M, 1, @FirstDayOfMonth))

       SET @FirstDayOfQuarter = CASE WHEN MONTH(@currentDate) IN (1, 2, 3) THEN CAST(YEAR(@currentDate) AS VARCHAR) + '-' + '01-01'

                                                                     WHEN MONTH(@currentDate) IN (4, 5, 6) THEN CAST(YEAR(@currentDate) AS VARCHAR) + '-' + '04-01'

                                                                     WHEN MONTH(@currentDate) IN (7, 8, 9) THEN CAST(YEAR(@currentDate) AS VARCHAR) + '-' + '07-01'

                                                                     WHEN MONTH(@currentDate) IN (10, 11, 12) THEN CAST(YEAR(@currentDate) AS VARCHAR) + '-' + '10-01'

                                                              END

       SET @LastDayOfQuarter = DATEADD(D, -1, DATEADD(MM, 3, @FirstDayOfQuarter))

             

       SET @WeekOfQuarter = CASE WHEN DATENAME(DW, @FirstDayOfQuarter) = 'Monday' THEN (DATEDIFF(D, @FirstDayOfQuarter, @CurrentDate))/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfQuarter) = 'Tuesday' THEN (DATEDIFF(D, @FirstDayOfQuarter, @CurrentDate)+1)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfQuarter) = 'Wednesday' THEN (DATEDIFF(D, @FirstDayOfQuarter, @CurrentDate)+2)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfQuarter) = 'Thursday' THEN (DATEDIFF(D, @FirstDayOfQuarter, @CurrentDate)+3)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfQuarter) = 'Friday' THEN (DATEDIFF(D, @FirstDayOfQuarter, @CurrentDate)+4)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfQuarter) = 'Saturday' THEN (DATEDIFF(D, @FirstDayOfQuarter, @CurrentDate)+5)/7 + 1

                                                WHEN DATENAME(DW, @FirstDayOfQuarter) = 'Sunday' THEN (DATEDIFF(D, @FirstDayOfQuarter, @CurrentDate)+6)/7 + 1

                                         END

       SET @WeekOfQuarter = CASE WHEN CAST(@WeekOfQuarter AS INT) <= 9 THEN '0' + CAST(CAST(@WeekOfQuarter AS INT) AS VARCHAR) ELSE @WeekOfQuarter END

 

       SET @FullDate = CONVERT(VARCHAR, @currentDate, 103)

       SET @DayOfWeek = DATEPART(DW, @CurrentDate)

      

       SET @DayOfWeekInMonth = CASE WHEN DATENAME(DW, @FirstDayOfMonth) = 'Monday'

                                                              THEN CASE

                                                                           WHEN @WeekOfMonth = 1 THEN  @WeekOfMonth + 'st ' + @dayName

                                                                           WHEN @WeekOfMonth = 2 THEN  @WeekOfMonth + 'nd ' + @dayName

                                                                           WHEN @WeekOfMonth = 3 THEN  @WeekOfMonth + 'rd ' + @dayName

                                                                           ELSE @WeekOfMonth + 'th ' + @dayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Tuesday' AND @DayOfWeek < 2

                                                              THEN CASE

                                                                           WHEN @WeekOfMonth-1 = 1 THEN  CAST(@WeekOfMonth-1 AS VARCHAR) + 'st ' + @dayName

                                                                           WHEN @WeekOfMonth-1 = 2 THEN  CAST(@WeekOfMonth-1 AS VARCHAR) + 'nd ' + @dayName

                                                                           WHEN @WeekOfMonth-1 = 3 THEN  CAST(@WeekOfMonth-1 AS VARCHAR) + 'rd ' + @dayName

                                                                           ELSE CAST(@WeekOfMonth-1 AS VARCHAR) + 'th ' + @dayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Tuesday' AND @DayOfWeek >= 2

                                                              THEN CASE

                                                                           WHEN @WeekOfMonth = 1 THEN  @WeekOfMonth + 'st ' + @dayName

                                                                           WHEN @WeekOfMonth = 2 THEN  @WeekOfMonth + 'nd ' + @dayName

                                                                           WHEN @WeekOfMonth = 3 THEN  @WeekOfMonth + 'rd ' + @dayName

                                                                           ELSE @WeekOfMonth + 'th ' + @dayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Wednesday' AND @DayOfWeek < 3

                                                              THEN CASE

                                                                           WHEN (CAST(@WeekOfMonth AS INT)-1) = 1 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'st ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 2 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'nd ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 3 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'rd ' + @DayName

                                                                           ELSE CAST(@WeekOfMonth-1 AS VARCHAR) + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Wednesday' AND @DayOfWeek >= 3

                                                              THEN CASE

                                                                           WHEN @WeekOfMonth = 1 THEN  ISNULL(@WeekOfMonth + 'st ' + @DayName, 'ZZZ')

                                                                           WHEN @WeekOfMonth = 2 THEN  @WeekOfMonth + 'nd ' + @DayName

                                                                           WHEN @WeekOfMonth = 3 THEN  @WeekOfMonth + 'rd ' + @DayName

                                                                           ELSE @WeekOfMonth + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Thursday' AND @DayOfWeek < 4

                                                              THEN CASE

                                                                           WHEN (CAST(@WeekOfMonth AS INT)-1) = 1 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'st ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 2 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'nd ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 3 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'rd ' + @DayName

                                                                           ELSE CAST(@WeekOfMonth-1 AS VARCHAR) + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Thursday' AND @DayOfWeek >= 4

                                                              THEN CASE

                                                                           WHEN @WeekOfMonth = 1 THEN  ISNULL(@WeekOfMonth + 'st ' + @DayName, 'ZZZ')

                                                                           WHEN @WeekOfMonth = 2 THEN  @WeekOfMonth + 'nd ' + @DayName

                                                                           WHEN @WeekOfMonth = 3 THEN  @WeekOfMonth + 'rd ' + @DayName

                                                                           ELSE @WeekOfMonth + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Friday' AND @DayOfWeek < 5

                                                              THEN CASE

                                                                           WHEN (CAST(@WeekOfMonth AS INT)-1) = 1 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'st ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 2 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'nd ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 3 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'rd ' + @DayName

                                                                           ELSE CAST(@WeekOfMonth-1 AS VARCHAR) + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Friday' AND @DayOfWeek >= 5

                                                              THEN CASE

                                                                           WHEN @WeekOfMonth = 1 THEN  ISNULL(@WeekOfMonth + 'st ' + @DayName, 'ZZZ')

                                                                           WHEN @WeekOfMonth = 2 THEN  @WeekOfMonth + 'nd ' + @DayName

                                                                           WHEN @WeekOfMonth = 3 THEN  @WeekOfMonth + 'rd ' + @DayName

                                                                           ELSE @WeekOfMonth + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Saturday' AND @DayOfWeek < 6

                                                              THEN CASE

                                                                           WHEN (CAST(@WeekOfMonth AS INT)-1) = 1 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'st ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 2 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'nd ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 3 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'rd ' + @DayName

                                                                           ELSE CAST(@WeekOfMonth-1 AS VARCHAR) + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Saturday' AND @DayOfWeek >= 6

                                                              THEN CASE

                                                                           WHEN @WeekOfMonth = 1 THEN  ISNULL(@WeekOfMonth + 'st ' + @DayName, 'ZZZ')

                                                                           WHEN @WeekOfMonth = 2 THEN  @WeekOfMonth + 'nd ' + @DayName

                                                                           WHEN @WeekOfMonth = 3 THEN  @WeekOfMonth + 'rd ' + @DayName

                                                                           ELSE @WeekOfMonth + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Sunday' AND @DayOfWeek < 7

                                                              THEN CASE

                                                                           WHEN (CAST(@WeekOfMonth AS INT)-1) = 1 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'st ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 2 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'nd ' + @DayName

                                                                           WHEN CAST(@WeekOfMonth AS INT)-1 = 3 THEN  CAST(CAST(@WeekOfMonth AS INT)-1 AS VARCHAR) + 'rd ' + @DayName

                                                                           ELSE CAST(@WeekOfMonth-1 AS VARCHAR) + 'th ' + @DayName END

                                                       WHEN DATENAME(DW, @FirstDayOfMonth) = 'Sunday' AND @DayOfWeek >= 7

                                                              THEN CASE

                                                                           WHEN @WeekOfMonth = 1 THEN  ISNULL(@WeekOfMonth + 'st ' + @DayName, 'ZZZ')

                                                                           WHEN @WeekOfMonth = 2 THEN  @WeekOfMonth + 'nd ' + @DayName

                                                                           WHEN @WeekOfMonth = 3 THEN  @WeekOfMonth + 'rd ' + @DayName

                                                                           ELSE @WeekOfMonth + 'th ' + @DayName END

                                                END

 

       SET @DayOfCalenderYear = DATEDIFF(D, CAST(YEAR(@currentDate) AS VARCHAR) + '-01-01', @currentDate) + 1

       SET @DayOfCalenderYear = CASE WHEN CAST(@DayOfCalenderYear AS  INT) <= 9 THEN '00' + CAST(CAST(@DayOfCalenderYear AS  INT) AS VARCHAR)

                                                       WHEN CAST(@DayOfCalenderYear AS  INT) <= 99 THEN '0' + CAST(CAST(@DayOfCalenderYear AS  INT) AS VARCHAR)

                                                       ELSE @DayOfCalenderYear END

 

       SET @WeekOfCalenderYear = DATEPART(wk, @CurrentDate)

       SET @WeekOfCalenderYear = CASE WHEN CAST(@WeekOfCalenderYear AS INT) <= 9 THEN '0' + CAST(CAST(@WeekOfCalenderYear AS INT) AS VARCHAR) ELSE @WeekOfCalenderYear END

 

       SET @CalenderMonth = MONTH(@currentDate)

       SET @CalenderMonth = CASE WHEN CAST(@CalenderMonth AS INT) <= 9 THEN '0' + CAST(CAST(@CalenderMonth AS INT) AS VARCHAR) ELSE @CalenderMonth END

 

       SET @CalenderQuarter = CASE WHEN MONTH(@currentDate) IN (1, 2, 3) THEN 1

                                                       WHEN MONTH(@currentDate) IN (4, 5, 6) THEN 2

                                                       WHEN MONTH(@currentDate) IN (7, 8, 9) THEN 3

                                                       WHEN MONTH(@currentDate) IN (10, 11, 12) THEN 4

                                                END

       SET @CalenderYear = YEAR(@currentDate)  

      

 

       SET @DayOfFinancialYear = CASE WHEN MONTH(@currentDate) IN (1, 2, 3) THEN  DATEDIFF(D, CAST((YEAR(@currentDate)-1) AS VARCHAR) + '-04-01', @currentDate) + 1

                                                              ELSE DATEDIFF(D, CAST(YEAR(@currentDate) AS VARCHAR) + '-04-01', @currentDate) + 1

                                                       END

       SET @DayOfFinancialYear = CASE WHEN CAST(@DayOfFinancialYear AS  INT) <= 9 THEN '00' + CAST(CAST(@DayOfFinancialYear AS  INT) AS VARCHAR)

                                                       WHEN CAST(@DayOfFinancialYear AS  INT) <= 99 THEN '0' + CAST(CAST(@DayOfFinancialYear AS  INT) AS VARCHAR)

                                                       ELSE @DayOfFinancialYear END

 

       SET @WeekOfFinancialYear = CASE WHEN MONTH(@CurrentDate) <= 3 THEN (DATEPART(wk, CAST((CAST(YEAR(@CurrentDate)-1 AS CHAR) + '-12-31') AS DATE)) - DATEPART(wk, CAST((CAST(YEAR(@CurrentDate)-1 AS CHAR) + '-04-01') AS DATE)) + DATEPART(wk, @CurrentDate))

                                                       ELSE (DATEPART(wk, @CurrentDate) - DATEPART(wk, CAST((CAST(YEAR(@CurrentDate) AS CHAR) + '-04-01') AS DATE)) + 1) END

       SET @WeekOfFinancialYear = CASE WHEN CAST(@WeekOfFinancialYear AS INT) <= 9 THEN '0' + CAST(CAST(@WeekOfFinancialYear AS INT) AS VARCHAR) ELSE @WeekOfFinancialYear END

 

       SET @FinancialMonth = CASE WHEN MONTH(@currentDate) IN (1, 2, 3) THEN 9+MONTH(@currentDate) ELSE MONTH(@currentDate)-3 END

       SET @FinancialMonth = CASE WHEN CAST(@FinancialMonth AS INT) <= 9 THEN '0' + CAST(CAST(@FinancialMonth AS INT) AS VARCHAR) ELSE @FinancialMonth END

 

       SET @FinancialQuarter = CASE WHEN MONTH(@currentDate) IN (1, 2, 3) THEN 4

                                                       WHEN MONTH(@currentDate) IN (4, 5, 6) THEN 1

                                                       WHEN MONTH(@currentDate) IN (7, 8, 9) THEN 2

                                                       WHEN MONTH(@currentDate) IN (10, 11, 12) THEN 3

                                                END

       SET @FinancialYear = CASE WHEN MONTH(@currentDate) IN (1, 2, 3) THEN  CAST((YEAR(@currentDate)-1) AS VARCHAR) + '/' + CAST((YEAR(@currentDate)) AS VARCHAR) ELSE CAST((YEAR(@currentDate)) AS VARCHAR) + '/' + CAST((YEAR(@currentDate)+1) AS VARCHAR) END

       SET @IsWeekday = CASE WHEN @DayOfWeek IN (6, 7) THEN 0 ELSE 1 END

      

       SET @IsHoliday = CASE WHEN EXISTS(SELECT * FROM @Holiday WHERE [Date] = @Date) THEN 1 ELSE 0 END

       SET @HolidayName = CASE WHEN @IsHoliday = 1 THEN (SELECT HolidayName FROM @Holiday WHERE [Date] = @Date) ELSE '' END

 

       INSERT INTO @DimDate

              (

              DateKey,

              [Date],

 

              [DayOfMonth],

              DayOfMonthWithSuffix,

              DayOfQuarter,

              DayOfQuarterWithSuffix,

              MonthOfQuarter,

 

              [DayName],

              DayOfWeekInMonth,

              WeekOfMonth,

              WeekOfQuarter,

              [MonthName],

              MonthYear,

              MMYYYY,

              FirstDayOfMonth,

              LastDayOfMonth,

              FirstDayOfQuarter,

              LastDayOfQuarter,

 

              FullDate,

              [DayOfWeek],

 

              DayOfCalenderYear,

              WeekOfCalenderYear,

              CalenderMonth,

              CalenderQuarter,

              CalenderYear,

 

              DayOfFinancialYear,

              WeekOfFinancialYear,

              FinancialMonth,

              FinancialQuarter,

              FinancialYear,

             

              [IsWeekday],

              IsHoliday,

              HolidayName

              )

       VALUES

              (     

              @DateKey,

              @Date,

 

              @DayOfMonth,

              @DayOfMonthWithSuffix,

              @DayOfQuarter,

              @DayOfQuarterWithSuffix,

              @MonthOfQuarter,

 

              @DayName,

              @DayOfWeekInMonth,

              @WeekOfMonth,

              @WeekOfQuarter,

              @MonthName,

              @MonthYear,

              @MMYYYY,

              @FirstDayOfMonth,

              @LastDayOfMonth,

              @FirstDayOfQuarter,

              @LastDayOfQuarter,

             

              @FullDate,

              @DayOfWeek,

 

              @DayOfCalenderYear,

              @WeekOfCalenderYear,

              @CalenderMonth,

              @CalenderQuarter,

              @CalenderYear,

 

              @DayOfFinancialYear,

              @WeekOfFinancialYear,

              @FinancialMonth,

              @FinancialQuarter,

              @FinancialYear,

             

              @IsWeekday,

              @IsHoliday,

              @HolidayName

       )

 

       SET @currentDate = DATEADD(D, 1, @currentDate)

END

 

SELECT * FROM @DimDate

 