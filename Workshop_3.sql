USE T5_Padmanabh
/* SQL WORKSHOP 3 */
create table sales_order
(
SALES_ORDER_NUM BIGINT, 
SALES_ORDER_LINE_NUM INT,
ITEM VARCHAR(40),
ORDER_PLACED_TS DATETIME,
ORDER_PLACED_DT DATETIME,
QTY SMALLINT,
UNIT_PRICE MONEY,
STATUS VARCHAR(40),
SRC_STS_UPD_TS DATETIME,
SRC_STS_UPD_DT DATETIME,
)
create table sales_order_lines
(
SALES_ORDER_NUM	BIGINT, 
ORDER_PLACED_TS	DATETIME,
ORDER_PLACED_DT	DATETIME,
TOT_AMT MONEY,
TAX_AMT	MONEY,
ORDER_REL_TS DATETIME,	
ORDER_REL_DT DATETIME,
STATUS	VARCHAR(40),
SRC_STS_CHNG_TS	DATETIME,
SRC_STS_CHNG_DT DATETIME,
)
select * from sales_order;
select * from sales_order_lines;

/* 1. compare the no of orders placed between today and the same day for last 3 months */

select  datediff(year,ORDER_PLACED_DT,getdate()) as years,(datediff(month,ORDER_PLACED_DT,getdate())%365/30) as months,
(datediff(day,ORDER_PLACED_DT,getdate())%365%30) as day_s
from sales_order 

