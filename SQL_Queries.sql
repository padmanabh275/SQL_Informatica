use T5_Padmanabh

select * from northwind_customer
select * from northwind_employee

create table [Dim_Region]
(
[RegionID] int not null,
[RegionDescription] nchar(50) not null 
)

select * from dim_region

create table Employee_empid
(
Empid Int, 
Ename varchar(50),
Title varchar(15)
)

select * from Employee_empid
 

create table dim_emp_detail 
 (
TitleOfCourtesy varchar(10),
First_name varchar(25),
Last_name varchar(25),
Title varchar(50),
City varchar(25),
Country varchar(25)
)

drop table dim_emp_detail
use T5_Padmanabh

create table dim_emp_detail
(
Full_name varchar(50),
Designation varchar(50),
Location varchar(50)
)
select * from dim_emp_detail

create table dim_sales_rep
(
EmployeeId int, 
First_name varchar(50),
Last_name varchar(50),
Title varchar(50)
)

use T5_Padmanabh
select * from dim_sales_rep

create table dim_Emp_Loc
(
EmployeeId int, 
First_name varchar(50),
Last_name varchar(50),
Title varchar(50),
City varchar(25),
Address varchar(50)
)
use T5_Padmanabh
select * from dim_Emp_Loc

Use Northwind

select * from Employees 
where city='LONDON' or city='London'

create table suppliers_empid
(
Company_Name varchar(50),
Contact_Name varchar(50),
Fax nvarchar(20)
)
use northwind
select * from employees
select * from dim_sales_rep

create table dim_emp_uk100
(
EmployeeID int, 
LastName varchar(50),
FirstName varchar(50),
Title varchar(75),
TitleOfCourtesy nvarchar(10),
BirthDate datetime,
HireDate datetime,
Address varchar(max),
City varchar(50),
Region varchar(10),
PostalCode nvarchar(20),
Country varchar(10),
HomePhone nvarchar(25),
Extension int, 
Photo varbinary(max),
Notes ntext,
ReportsTo int,
PhotoPath nvarchar(255)
)
use T5_Padmanabh

select * from dim_emp_uk100
alter table dim_emp_uk100 alter column Photo varchar(max)

create table dim_sales_97
(
CategoryName varchar(50),
ProductName varchar(50),
ProductSales float 
)

Use Northwind

select * from orders
select * from employees
SELECT pro.productname,emp.FirstName
FROM order_details as ordd
join orders as ord on ord.orderid=ordd.orderid
JOIN products as pro on pro.ProductID=ordd.productid
join employees as emp on emp.employeeid=ord.employeeid
where emp.employeeid IN (SELECT EMPLOYEEID FROM EMPLOYEES WHERE TITLE='SALES MANAGER')

use t5_Padmanabh

create table tgt_inflex_t3
(
productname varchar(30),
firstname varchar(20)
)

select * from tgt_inflex_t3


select pro.productname,cat.categoryName,sup.CompanyName
from categories as cat
join products as pro on cat.CategoryID=pro.CategoryID
join Suppliers as sup on pro.SupplierID=sup.SupplierID 

select orderid,cust.contactname,orderdate,shipcountry
from orders
join customers as cust on orders.customerid=cust.customerid
where orders.shipcountry='Brazil'

Use T5_Padmanabh 

create table tgt_infex_t2
(
orderid varchar(20),
contactname varchar(50),
orderdate datetime,
shipcountry varchar(20)
)

create table tgt_infex_t9
(
orderid varchar(20),
contactname varchar(50),
orderdate datetime,
shipcountry varchar(20),
shipname varchar(20)
)

select * from tgt_infex_t9


select * from tgt_infex_t2


Create table Tgt_Infex_T1
(
ProductName varchar(50),
CategoryName varchar(50),
CompanyName varchar(50)
)

select * from Tgt_infex_t1

select * from orders

select * from orders 
where shippeddate=datepart(year,1997)

use T5_Padmanabh
select * from dim_sales_97

use northwind

select * from suppliers
select * from products

select productid,productname,
case when sup.region=NULL then concat((upper(substring(sup.country,1,1))),(upper(substring(sup.city,1,1)))) end as New_Region
from suppliers as sup 
join products as pro on sup.supplierid=pro.supplierid
use t5_Padmanabh
create table tgt_infex_t4
(
supplierid int, 
companyname varchar(50),
contactname varchar(25),
contacttitle varchar(25),
Address varchar(50),
city varchar(20),
region varchar(15),
postalcode varchar(10),
country varchar(10),
phone int,
fax int,
homepage varchar(max)
)
select * from tgt_infex_t4

alter table tgt_infex_t5 alter column UnitPrice decimal
(
CompanyName varchar(50),
ContactName varchar(50),
City varchar(20),
UnitPrice decimal
)

select CompanyName,ContactName,City,UnitPrice 
from products as pro 
join suppliers as sup on pro.SupplierID=sup.SupplierID
/* have 2 fetch all records on suppliers table  where the value is null in column using logic of case function when in every coloumn=0 or null */

select * from tgt_infex_t5

Use northwind

select ord.CustomerID,ord.ShipName,ter.TerritoryDescription,ordd.UnitPrice,ter.TerritoryID,ord.shipcity,
case 
when ordd.Discount=0 then ordd.UnitPrice*0.06
else ordd.Discount
end as Discount
from EmployeeTerritories as empt 

join orders as ord on empt.EmployeeID=ord.EmployeeID
join Order_Details as ordd on ord.OrderID=ordd.OrderID
join Territories as ter on empt.TerritoryID=ter.TerritoryID
where (len(cast(ter.TerritoryID as int)))<4 and (ShipVia=1) or(ShipVia=2)


use t5_padmanabh

create table tgt_infex_t6
(
customerid varchar(10),
ShipName varchar(25),
TerritoryDescription varchar(25),
Unitprice decimal, 
territoryid int,
shipcity varchar(25),
discount decimal
)

select * from tgt_infex_t6


select ord.OrderID,ord.CustomerID,Ordd.UnitPrice,ordd.Discount
from customers as cust 
join orders as ord on cust.CustomerID=ord.CustomerID
join order_details as ordd on ord.OrderID=ordd.OrderID
where ordd.Discount>0


create table tgt_infex_t7
(
orderid varchar(20),
customerid varchar(20),
unitprice int,
quantity int,
discount int
)

select * from tgt_infex_t2

use northwind

select * from employees
use t5_padmanabh
create table tgt_emp
(
EmployeeID int, 
firstname varchar(50),
birthdate datetime,
hiredate datetime,
city varchar(25)
)
create table src_emp_scd2
(
EmployeeID int primary key,
firstname varchar(50),
birthdate datetime,
hiredate datetime,
city varchar(25)
)
alter table src_emp_scd2 
	add  empid int

select * from src_emp_scd2
insert into src_emp_scd1
values (1,1,'assa',12-12-2015,15-02-1986,'jay')



select * from tgt_emp_scd1

create table tgt_infex_t8
(
categoryid int, 
categoryname varchar(50),
description varchar(50), 
productname varchar(50),
supplierid int,
unitprice float
)

create table src_emp2_scd2
(
empid int primary key, 
ename varchar(20),
salary int,
create_date date,
update_date date
)

create table tgt_emp2_scd2
(
emp_surr_key int primary key,
empid int,
ename varchar(20),
salary int,
Eff_Start_date date,
Eff_End_date date
)

insert into src_emp2_scd2 values (7369,'smith',24000,'9/15/2015','9/19/2015')


create table emp_src
(
empno int,
ename varchar(25),
job varchar(20),
mgr varchar(20),
hiredate date,
sal int,
deptno int
)
create table emp_trg1
(
emplkey int primary key,
empno int,
ename varchar(25),
job varchar(20),
mgr varchar(20),
hiredate date,
sal int, 
deptno int,
start_dt date,
end_dt date
)

use t5_padmanabh

alter table emp_trg1
drop emplkey 

alter table emp_trg1 add constraint emp_d_pk primary key (emplkey)

select * from emp_src

insert into emp_src values (1,'padmanabh','clerk','rads','2015-05-05',10000,1)

use northwind
select * from employees
use t5_padmanabh
create table test_emp
(
empno int,
sal int,
start_dt date,
end_dt date,
version int,
flag  int
)
create table test_tgt
(
emplkey int primary key,
empno int ,
sal int,
start_dt date,
end_dt date,
version int,
flag  int
)

create table products_rank_empid
(
productid int,
productname varchar(100),
supplierid int,
unitprice decimal(10,2),
rank1 int
)

select * from products_rank_empid


create table lkp_employee_id
(
employee_id int not null, 
first_name varchar(20) null,
salary numeric(8,2) null,
manager_id int null,
mapping_name varchar(50) null
)

select * from lkp_employee_id ;


delete from lkp_employee_id where employee_id!=100

CREATE TABLE CUST 
( CUST_ID int,
CUST_NM  VARCHAR(250), 
ADDRESS VARCHAR(250), 
CITY VARCHAR(50), 
STATE VARCHAR(50), 
INSERT_DT DATE, 
UPDATE_DT DATE)

insert into cust values (80001,'Marion Atkins','100 Main St.','Bangalore','KA','1/7/2011','1/7/2011')
insert into cust values (80002,'Laura Jones','510 Broadway Ave.','Hyderabad','AP','1/7/2011','1/7/2011')
insert into cust values (80003,'Jon Freeman','555 6th Ave.','Bangalore','KA','1/7/2011','1/7/2011')

select * from cust

CREATE TABLE CUST_D1
(
PM_PRIMARYKEY int primary key,
CUST_ID int,
CUST_NM VARCHAR(250),
ADDRESS VARCHAR(250),
CITY VARCHAR(50),
STATE VARCHAR(50),
ACTIVE_DT DATE,
INACTIVE_DT DATE,
INSERT_DT DATE,
UPDATE_DT DATE)

select * from cust_d


-- tgt_infex_t10 

create table tgt_infex_t10_shipvia3
(
productname varchar(30),
shipvia varchar(20)
)

alter table tgt_infex_t10_shipvia1
 add firstname varchar(20)

select * from tgt_infex_t10_shipvia2


select * from products;
select * from employees;
select * from Orders;
select * from [dbo].[Shippers]

select concat (emp1.FirstName,' ',emp1.LastName),pro.ProductName
from products as pro,employees as emp1
join orders as ord on emp1.EmployeeID=ord.EmployeeID
where emp1.EmployeeID in (select ReportsTo from employees as emp2)
group by emp1.FirstName,emp1.LastName,pro.ProductName

use northwind
select * from [dbo].[Categories]
select * from [dbo].[Products]

use t5_padmanabh

create table dim_sales97
(
categoryname varchar(20),
productname varchar(50),
productsales float
)

use northwind
select * from products
use t5_padmanabh
create table dim_prod_class
(
productid int, 
productname varchar(50),
supplierid int, 
categoryid int, 
quantityperunit varchar(50),
unitprice decimal, 
unitsinstock int, 
unitsonorder int, 
reorderlevel int, 
discountinued int
)
drop table dim_prod_class
create table dim_prod_class
(
productid int, 
class varchar(5),
quantityperunit int
)

select * from dim_prod_class



select * from dim_prod_class

create table dim_sales
(
orderid int, 
productid int, 
Unitprice decimal, 
quantity int, 
discount decimal
)
alter table dim_sales alter column discount varchar(10)
use t5_Padmanabh
select * from Trial_Dim_Sales1

use northwind
select * from customers

create table dim_cust_bad
(
customerid varchar(10),
customername varchar(50),
contactname varchar(50),
contacttitle varchar(25),
address varchar(50),
city varchar(25),
region varchar(20),
postalcode int, 
country varchar(20),
phone varchar(20),
fax varchar(20)
)
use t5_padmanabh
select * from dim_cust_clean

create table prod_delivery 
(
productname varchar(40),
quantityperunit varchar(20),
supplierid int, 
categoryid int, 
requiredunits int, 
amount decimal
)

select * from prod_delivery

use northwind
use t5_padmanabh
create table Convey_via3
(
orderid int,
CustomerID varchar(10),
employeeid int, 
orderdate date,
requiredate date, 
shipvia int
)



SELECT OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate, ShipVia
FROM Orders
WHERE (ShippedDate IS NULL)
AND (ShipVia = 3)


create table dim_stock_list
(
categoryname varchar(50),
productname varchar(50),
quantityperunit int,
unitsinstock int, 
discountinued varchar(10)
)
use northwind
select * from products

select * from categories
use t5_padmanabh
select * from dim_stock_list
select * from [dbo].[Suppliers]

use t5_padmanabh
create table order_with_phone
(
productname varchar(25),
quantityperunit int,
companyname varchar(25),
contactname varchar(25),
fax varchar(25),
categoryid int, 
requiredunits int,
amount int
)
SP_RENAME 'order_with_phone.fax','phone'

select * from order_with_fax

create table file_structure
(
firstname varchar(25),
lastname varchar(25),
total_sales decimal
)

use t5_padmanabh
select * from emp_salary

create table emp_id_append
(
empid int, 
deptid int, 
salary int, 
managername varchar(30)
)

alter table emp_id_append alter column empid varchar(10)	

select * from emp_id_append

use northwind

select * from orders

use t5_padmanabh
create table ship_Add_num
(
shipaddress varchar(50),
total_sum int
)

select * from ship_add_num

select * from ship_add_num
create table supplier_rollup
(
supplierid int, 
productname varchar(50),
total_inventory decimal(15,2) 
)
use t5_padmanabh

select * from supplier_rollup

use northwind
select * from products

create table running_sales
(
orderid int, 
productid int,
unitprice decimal (10,2),
quantity int, 
discount decimal (5,2),
sales decimal (15,2),
running_sum decimal (10,2),
running_avg decimal (10,2)
)
	
select * from running_sales

use northwind
select * from customers
use t5_padmanabh
create table dim_customers 
(
cust_key int, 
customerid varchar(10),
companyname varchar(50),
contactname varchar(25),
address varchar(40),
city varchar(25), 
region varchar(20),
postalcaode varchar(15),
country varchar(20),
phone varchar(20),
fax varchar(20)
)

select * from dim_customers

create table empl_concat
(
empname varchar(50), 
doj varchar(20)
)
select * from empl_concat
use t5_padmanabh
select * from lkp_employee_id