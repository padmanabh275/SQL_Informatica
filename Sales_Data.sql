use northwind

select * from [dbo].[Categories]
select * from [dbo].[Employees]
select * from [dbo].[EmployeeTerritories]
select * from [dbo].[Customers]
--select * from [dbo].[DailyLoad$]
select * from [dbo].[MPS]
select * from [dbo].[Order_Details]
select * from [dbo].[Orders]
select * from [dbo].[Products]
	select * from [dbo].[Region]
select * from [dbo].[Shippers]
select * from [dbo].[Suppliers]
select * from [dbo].[Territories]

--insert  into Sales1 from
CREATE TABLE Sales_Trial AS 
INSERT INTO Sales_Trial SELECT        { fn CONCAT(emp.FirstName, emp.LastName) } AS Name, prod.ProductName, cust.CompanyName, sup.CompanyName AS Expr1, ter.TerritoryDescription, 
                         region.RegionDescription, prod.UnitsInStock, COUNT(ordd.OrderID) AS Sales_Count, COUNT(cust.CustomerID) AS By_Customer, COUNT(ord.EmployeeID) 
                         AS By_Employee, ship.CompanyName AS Expr2, DATEPART(month, ord.ShippedDate) AS MonthID
FROM            Employees AS emp INNER JOIN
                         EmployeeTerritories AS empte ON emp.EmployeeID = empte.EmployeeID INNER JOIN
                         Orders AS ord ON empte.EmployeeID = ord.EmployeeID INNER JOIN
                         Order_Details AS ordd ON ord.OrderID = ordd.OrderID INNER JOIN
                         Products AS prod ON prod.ProductID = ordd.ProductID INNER JOIN
                         Suppliers AS sup ON prod.SupplierID = sup.SupplierID INNER JOIN
                         Territories AS ter ON ter.TerritoryID = empte.TerritoryID INNER JOIN
                         Region AS region ON region.RegionID = ter.RegionID INNER JOIN
                         Customers AS cust ON cust.CustomerID = ord.CustomerID INNER JOIN
                         Shippers AS ship ON ord.ShipVia = ship.ShipperID
GROUP BY emp.FirstName, emp.LastName, prod.ProductName, cust.CompanyName, sup.CompanyName, ter.TerritoryDescription, region.RegionDescription, prod.UnitsInStock, 
                         ship.CompanyName, ord.ShippedDate
use T5_Padmanabh




create table Sales_Report
(
	[Sales_Report] identity not null
	[Employee_Name] varchar(255)
	[Product_Name] varchar(255)
	[Customer_Name] varchar(255)
	[Supplier_Name] varchar(255)
	[Territory_Name] varchar(255)
	[Region_Name] varchar(255)
	[Quantity] int
	[Sales_Count] int
	[No_of_Orders_Placed_byCustomer] int
	[No_of_Orders_byEmployee] int
	[Shipper_name] varchar(255)
	[MonthID] varchar(20)


)

-- Control TBL 
create table control1
(
	[LoadID] 
	[LoadName]
	[Load_by]
	[Load_Date]
	[Load_St_Date]
	[Load_Ed_Date]
	[Insert_Dt]
	[Upate_Dt]
	[Insert_by_Date]
	[Updated_by_Date]
	[No_of_columns_old]
	[No_of_columns_new]
	[History_type]
	[SCD_type]
	[Status]
)

use northwind

select COUNT(orders.OrderID) AS NumberOfOrders FROM orders LEFT JOIN shippers ON orders.ShipVia = shippers.ShipperID WHERE shippers.CompanyName='Federal Shipping';
SELECT COUNT(orders.OrderID) AS NumberOfOrders FROM orders LEFT JOIN shippers ON orders.ShipVia = shippers.ShipperID WHERE shippers.CompanyName='Speedy Express';
SELECT COUNT(orders.OrderID) AS NumberOfOrders FROM orders LEFT JOIN shippers ON orders.ShipVia = shippers.ShipperID WHERE shippers.CompanyName='United Package';
SELECT shippers.CompanyName, COUNT(orders.OrderID) AS NumberOfOrders FROM orders LEFT JOIN shippers ON orders.ShipVia = shippers.ShipperID GROUP BY CompanyName;

SELECT COUNT(CustomerID) AS OrdersFromCustomerIDLINOD FROM orders WHERE CustomerID='LINOD';


-- required fields - sales_report_surrogatekey,employee_name,product_name,customer_name,supplier_name,territory_name,
-- region_name,qty,sales_count,no_of_orders_palcedbycustomer,no_of_orders_byemploee,shipper_name,monthid
--Control tbl - loadid,loadname,loadby,loaddate,load_st_dt,load_end_dt,insert_dt,update_dt,no_of_col_old,
-- no_of_col_new,_history_type,scd_type,status

