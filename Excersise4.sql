/*Database Name: Northwind*/
use northwind;
SELECT * FROM INFORMATION_SCHEMA.TABLES
/*1.	Write a query to display the Customer details and order details of the customers who have ordered between '1996-07-01' and '1997-07-01'.*/
SELECT
	Table_name,COLUMN_NAME,*
FROM
  	INFORMATION_SCHEMA.COLUMNS
where 
column_name like '%customer%'

select * from [dbo].[Orders];
select * from [dbo].[Customers];
select cust.ContactName,ord.ShipVia,ord.ShipName
from [dbo].[Customers] as cust 
join [dbo].[Orders] as ord 
on cust.CustomerID=ord.CustomerID
where ord.ShippedDate between '1996-07-01' and '1997-07-01';


/*2.	Display the EmployeeID, First name, last name, territory description and region description of the employees who are working in ‘Eastern’ region under ‘Cambridge’ territory.*/
select * from [dbo].[Employees];
select * from [dbo].[EmployeeTerritories];
select * from [dbo].[Territories];
select * from [dbo].[Region];

select emp.EmployeeID,Emp.FirstName,Emp.LastName,Ter1.TerritoryDescription,Emp.Region
from [dbo].[Employees] as emp 
join [dbo].[EmployeeTerritories] as ter on emp.EmployeeID=ter.EmployeeID
join [dbo].[Territories] as ter1 on ter.TerritoryID=ter1.TerritoryID
join [dbo].[Region] as reg on reg.RegionID=ter1.RegionID
where reg.RegionDescription='Eastern' and ter1.TerritoryDescription='Cambridge'; 


/*3.	Display the CustomerID, contactname, orderid, productname and ShipperName in the resultset. 
Retrieve the orderdetails placed by the customer with the product name under the category 
‘Daily Products’ and the order should be shipped via ‘Speedy Express’.*/
select * from [dbo].[Customers];
select * from [dbo].[Orders]
select * from [dbo].[Shippers]
select * from [dbo].[Order_Details];
select * from [dbo].[Products]
select cust.CustomerID,cust.ContactName,ord.OrderID
from [dbo].[Customers] as cust
join [dbo].[Orders] as ord on cust.CustomerID=ord.CustomerID

/*4.	Display the orderid, ProductName, Unitprice, Quantity and New_Discount based on the below condition.
a.	If the discount is 0 then calculate the New_Discount as 2% of the Unit price.
b.	If the discount > 0.1 then calculate the New_Discount as 3% of the Unit price.
c.	If the discount < 0.1 then calculate the New_Discount as 4% of the Unit price.
d.	Else calculate the New_Discount as 6% of the Unit price.*/
select * from [dbo].[Orders];
select * from [dbo].[Products]
select * from [dbo].[Order_Details];

select ord.orderid,pro.ProductName,det.Unitprice,det.Quantity,
case when discount=0 then (det.UnitPrice*0.02)
     when discount>0.1 then (det.Unitprice*0.03)
	 when discount<0.1 then (det.Unitprice*0.04)
	 else (det.Unitprice*0.06) 
	 end as New_Discount
from [dbo].[Products] as Pro,[dbo].[Orders] as ord 
join [dbo].[Order_Details] as det on ord.OrderID=det.OrderID; 

/*5.	Use the above result set and calculate the cost of each product and name the column as ‘Cost’. (Use the columns Unitprice, Quantity, New_Discount) */

select ord.orderid,pro.ProductName,det.Unitprice,det.Quantity,
case when discount=0 then (det.UnitPrice*0.02)
     when discount>0.1 then (det.Unitprice*0.03)
	 when discount<0.1 then (det.Unitprice*0.04)
	 else (det.Unitprice*0.06) 
	 end as New_Discount,
	 case
	 when discount=0 then (det.UnitPrice*0.02)
     when discount>0.1 then (det.Unitprice*0.03)
	 when discount<0.1 then (det.Unitprice*0.04)
	 else (det.Unitprice*0.06) 
	 end as cost 
from [dbo].[Products] as Pro,[dbo].[Orders] as ord 
join [dbo].[Order_Details] as det on ord.OrderID=det.OrderID; 



/*6.	Display the CustomerID, Contact Name and Company Name of the customer, who have not placed any orders.*/

select * from [dbo].[Orders];
select * from [dbo].[Customers];
select * from [dbo].[Order_Details];
select ord1.CustomerID,ord1.ContactName,ord1.CompanyName
from [dbo].[Orders] as ord 
join [dbo].[Customers] as ord1 on ord.CustomerID=ord1.CustomerID
where ord.CustomerID <> ord1.CustomerID

/*7.	Display Productname, CategoryID, Unitprice, Unitsinstock, unitsonorder, reorderlevel, Supplier_Existence, CompanyName as supplier, contactname as Supplier_Name, Address as Supplier_Address, Phone AS Supplier_Phone. Display the Supplier_Existence based on the conditions mentioned below.
a.	If discontinued = 0 then display as ‘Supplier Exists’ else ‘Not Exists’ */
select * from [dbo].[Suppliers]
select * from [dbo].[Products]
select pro.ProductName,pro.CategoryID,pro.Unitprice,pro.Unitsinstock,pro.UnitsonOrder,pro.reorderlevel,sup.CompanyName as Supplier, sup.ContactName as Supplier_Name,sup.Address as Supplier_Address,sup.Phone As Supplier_Phone,
case when pro.Discontinued=0 then 'suppliers exists'
else 'suppliers Not Exists' end as supplier_existence
from [dbo].[Suppliers] as sup 
join [dbo].[Products] as pro on sup.SupplierID=pro.SupplierID



/*8.	Use the above result and filter for the records ‘Supplier Exists’.*/
/*Display the unit of products that are ordered even though units are already in stock, that falls under the categories ‘confections’ and ‘Daily Products’.*/
select pro.ProductName,pro.CategoryID,pro.Unitprice,pro.Unitsinstock,pro.UnitsonOrder,pro.reorderlevel,sup.CompanyName as Supplier, sup.ContactName as Supplier_Name,sup.Address as Supplier_Address,sup.Phone As Supplier_Phone,
case when pro.Discontinued=0 then 'suppliers exists'
else 'suppliers Not Exists' end as supplier_existence
from [dbo].[Suppliers] as sup 
join [dbo].[Products] as pro on sup.SupplierID=pro.SupplierID
where pro.Unitsinstock <> 0 and
(case
when pro.Discontinued=0 then 'suppliers exists'
else 'suppliers Not Exists'
end ) = 'suppliers exist';



/*9.	Display the Employee details and their manager details using the table Employees.*/

select * from [dbo].[Employees];

select concat (emp1.FirstName,emp.LastName) as Employee_Name,concat (emp.FirstName,emp.LastName) as Manager
from [dbo].[Employees] as emp 
join [dbo].[Employees] as emp1 on emp.EmployeeID= emp1.ReportsTo
where emp1.ReportsTo=emp.EmployeeID ;


/*10.	Display the employees details who do not have managers.*/
select concat (emp1.FirstName,emp.LastName) as Employee_Name,concat (emp.FirstName,emp.LastName) as Manager
from [dbo].[Employees] as emp 
join [dbo].[Employees] as emp1 on emp.EmployeeID= emp1.ReportsTo
where emp1.ReportsTo is NULL;



/*11.	 Display the Customer details who are attended by the Sales Representatives and the orders were placed after 1996-10-03 and the shipping would be done before 1997-09-30.*/
select * from [dbo].[Customers];
select * from [dbo].[Orders];

select cust.ContactName,cust.Address
from [dbo].[Customers] as cust
join  [dbo].[Orders] as ord on cust.CustomerID= ord.CustomerID
where cust.ContactTitle='Sales Representative'and ord.ShippedDate between '1996-10-03' and '1997-09-30'


/*12.	Use the above result set and get the Shipper Details.*/

select * from [dbo].[Customers];
select * from [dbo].[Orders];
select * from [dbo].[Shippers];

select cust.ContactName,cust.Address,ship.CompanyName
from [dbo].[Customers] as cust
join  [dbo].[Orders] as ord on cust.CustomerID= ord.CustomerID
join [dbo].[Shippers] as ship  on ord.ShipVia=ship.ShipperID 
where cust.ContactTitle='Sales Representative'and ord.ShippedDate between '1996-10-03' and '1997-09-30'
