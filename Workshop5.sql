/* Workshop 5*/

use Northwind;

/* 1 display the product names along with their supplier names */

select * from [dbo].[Products]
select * from [dbo].[Suppliers]
select * from [dbo].[Categories]
select pro.ProductName,sup.CompanyName
from products as pro
join suppliers as sup on 
pro.SupplierID=sup.SupplierID

/*2 Display the product names and the category which the products fall under.Also,display the supplier's name */

select pro.ProductName,cat.CategoryName,sup.CompanyName
from products as pro
join suppliers as sup on 
pro.SupplierID=sup.SupplierID
join categories as cat on 
cat.CategoryID=pro.CategoryID

/*3 Display the Order_id,Contact Name,and the no of products purchased by the customer */
select * from Customers;
select * from Orders;
select * from [dbo].[Order_Details]
select cust.ContactName,count(ord.OrderID) as No_of_products
from Customers as cust 
join Orders as ord on
cust.CustomerID=ord.CustomerID
group by ContactName

/*4 Display the Order_id, Contact Name, and the shipping company name having brazil as the ship country */
select * from [dbo].[Customers];
select * from [dbo].[Orders];
select * from [dbo].[Shippers];

select cust.ContactName,ord.OrderID,ship.CompanyName
from Customers as cust
join Orders as ord on cust.CustomerID= ord.CustomerID
join Shippers as ship  on ord.ShipVia=ship.ShipperID 
where ord.ShipCountry='Brazil'

/* 5 Display the Order_id,contact name along with the employee's name who handled that sale.Also, Display the 
total amount of that particular order */
select * from Employees
select * from orders;
select * from Order_Details

select ord.OrderID,concat (emp.FirstName,emp.LastName) as Employee_name,
case 
when ord1.Discount =0 then ord1.UnitPrice * ord1.Quantity
when ord1.Discount !=0 then ord1.UnitPrice*ord1.Quantity*ord1.Discount
end as Amount
from Employees as emp
join orders as ord on emp.EmployeeID=ord.EmployeeID
join Order_Details as ord1 on ord.OrderID=ord1.OrderID
where  ord.OrderID in (select OrderID from Order_Details group by OrderID)
group by ord.OrderID,ord.OrderID,emp.FirstName,emp.Lastname,ord1.Discount,Ord1.UnitPrice,ord1.Quantity
order by ord.OrderID

use northwind
/* 6 Display the product Names that were sold by the Sales Manager */

select * from products;
select * from employees;
select * from Orders;
select * from [dbo].[Shippers]

select concat (emp1.FirstName,' ',emp1.LastName),pro.ProductName
from products as pro,employees as emp1
join orders as ord on emp1.EmployeeID=ord.EmployeeID
where emp1.EmployeeID in (select ReportsTo from employees as emp2)
group by emp1.FirstName,emp1.LastName,pro.ProductName

/*7 Fetch all the coloumns from suppliers with the corresponding product id and product name 
if the region is null concatenate the first letters of country and city, should appear in upper case */

select * from Suppliers
select * from [dbo].[Shippers]
select * from Products
select pro.productID,pro.ProductName,sup.SupplierID,CompanyName,ContactName,ContactTitle,Address,PostalCode,Country,Phone,Fax,HomePage,
case 
when sup.Region is NULL then concat(upper(left(sup.country,1)),' ',upper(left(city,1)))
when sup.Region is not Null then sup.Region
end as Region
from suppliers as sup
join Products as pro on sup.SupplierID=pro.SupplierID

/*8 Display the company name,contact name,city along with the unit price of products.
fetch all the records from suppliers. handle the null values */
select * from Products
select * from Suppliers

select CompanyName,ContactName,City,UnitPrice 
from products as pro 
join suppliers as sup on pro.SupplierID=sup.SupplierID
/* have 2 fetch all records on suppliers table  where the value is null in column using logic of case function when in every coloumn=0 or null */

/*9 select customerid,ship name,ship city,territory description,unit price,and discount wherein the territory id 
should not exceed four characters and the ship via should be 1 or 2. if the discount is 0,
then replace it with 6% unit price */
select * from [dbo].[EmployeeTerritories]
select * from [dbo].[Territories]
select * from [dbo].[Order_Details]
select * from [dbo].[Orders]
select * from [dbo].[Products]

select ord.CustomerID,ord.ShipName,ter.TerritoryDescription,ordd.UnitPrice,ter.TerritoryID,
case 
when ordd.Discount=0 then ordd.UnitPrice*0.06
else ordd.Discount
end as Discount
from EmployeeTerritories as empt 

join orders as ord on empt.EmployeeID=ord.EmployeeID
join Order_Details as ordd on ord.OrderID=ordd.OrderID
join Territories as ter on empt.TerritoryID=ter.TerritoryID
where (len(cast(ter.TerritoryID as int)))<4 and (ShipVia=1) or(ShipVia=2)
--and (len(convert(varchar(10),empt.TerritoryID))<=4)


--group by empt.TerritoryID,ord.CustomerID,ord.ShipName,ter.TerritoryDescription,ordd.UnitPrice,ordd.Discount,ordd.UnitPrice
--having empt.TerritoryID= (emp.TerritoryID<=4)

/* 10 Display the orderID,customerID,Unitprice,quantity where the discount should be greater then 0 */
select * from [dbo].[Customers]
select * from [dbo].[Orders]
select * from [dbo].[Order_Details]

select ord.OrderID,ord.CustomerID,Ordd.UnitPrice,ordd.Discount
from customers as cust 
join orders as ord on cust.CustomerID=ord.CustomerID
join order_details as ordd on ord.OrderID=ordd.OrderID
where ordd.Discount>0


/*11 select the categoryid,categoryname,description,productname,supplierid and unitprice. where 
the description should not exceed 2 subcategories*/

use northwind
select * from [dbo].[Categories]
select * from [dbo].[Products]	


select cat.categoryID,cat.CategoryName,cat.Description,pro.ProductName,pro.SupplierID,pro.UnitPrice,
--dense_rank () over(order by cat.CategoryID) row_number() over (partition by cat.categoryID order by cat.categoryID)),
row_number()over(partition by cat.CategoryID order by cat.CategoryID)
from categories as cat
join products as pro on cat.CategoryID=pro.CategoryID
--where count (cat.CategoryID)>2
--where cast(cat.Description as int)<=2


/*12 write a query to select only the first letter in each word present in column 'Contact Name'
e.g. A Beautiful Mind - ABM and name this column as short name. do order by short form 
use suppliers table */

select * from suppliers

select ltrim (rtrim(LEFT(ContactName,1)))
while charindex(' ',ContactName)>0
begin 
select ltrim(right(ContactName,1),len(ContactName))
from suppliers
,len(ContactName))
 -charindex(' ',ContactName)))
end
from suppliers

select left(territoryid,4) from territories