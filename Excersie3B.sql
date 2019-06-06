/*8 Database Name: AdventureWorks*/

use AdventureWorks;
SELECT * FROM INFORMATION_SCHEMA.TABLES
SELECT
	Table_name,COLUMN_NAME,*
FROM
  	INFORMATION_SCHEMA.COLUMNS
where 
column_name like '%sales%'



select * from AdventureWorks.[HumanResources].[vEmployee];
select * from AdventureWorks.[Sales].[SalesPerson];
select * from AdventureWorks.[Sales].[vSalesPerson];
select * from AdventureWorks.[HumanResources].[Employee];
select * from AdventureWorks.[Sales].[Individual]; /* field- customerid,contactid,demographics,ModifiedDate */


select * from AdventureWorks.[HumanResources].[EmployeePayHistory];


/*1. Write a query to display employee numbers and employee name (first name, last name) of all the sales employees who received an amount of 2000 in bonus.*/

select concat (Sales_Detail.FirstName,' ',Sales_Detail.LastName) as Emp_Name,Sales_Detail.SalesPersonID as Emp_No 
from AdventureWorks.[Sales].[vSalesPerson] as Sales_Detail 
join AdventureWorks.[Sales].[SalesPerson] as Bonus
on Sales_Detail.SalesPersonID=Bonus.SalesPersonID
where Bonus.Bonus = 2000;

 /*2. Fetch address details of employees belonging to the state CA. If address is null, provide default value N/A. */

select * from [Person].[Address];
select * from AdventureWorks.[HumanResources].[vEmployee];

select isnull(Emp.AddressLine1,'n/a') as Add1, isnull(emp.AddressLine2,'n/a') as Add2,Emp.StateProvinceName
from [HumanResources].[vEmployee] as Emp where Emp.StateProvinceName='California';  

/*3. Write a query that displays all the products along with the SalesOrderID even if an order has never been placed for that product.*/

select * from [Sales].[SalesOrderDetail];
select * from [Production].[ProductCategory];
select * from [Production].[Product];

select  Product.Name,SalesOrderId.SalesOrderID
from [Production].[Product] as Product join [Sales].[SalesOrderDetail] as SalesOrderId on Product.ProductID=SalesOrderID.ProductID
where SalesOrderId.SalesOrderDetailID is not null;

/*4. Find the subcategories that have at least two different prices less than $15.*/

select * from [Production].[ProductListPriceHistory];
select * from [Production].[ProductModelProductDescriptionCulture];
select * from [Production].[vProductAndDescription];
select * from [Production].[vProductModelCatalogDescription];
select * from [Production].[ProductCategory];

select * from [Production].[Product];
select * from [Production].[ProductSubcategory];
select sub.name,Pro.Listprice
from [Production].[Product] as Pro 
join [Production].[ProductSubcategory] as Sub on Pro.ProductsubcategoryID=Sub.ProductsubcategoryID
where Pro.Listprice<15 ;

/*5. A. Write a query to display employees and their manager details. Fetch employee id,   employee first name, and manager id, manager name.*/

select * from [HumanResources].[Employee];
select * from [Person].[Contact];

select Emp.EmployeeID,Per.FirstName,Emp.ManagerID
from [HumanResources].[Employee] as Emp
join [Person].[Contact] as Per on 
emp.ContactID=Per.ContactID 
inner join [HumanResources].[Employee] as Emp2
on Emp.EmployeeID= Emp2.ManagerID
/* EXTRACT NAME OF THE MANAGER FROM MANAGER ID */


/*Display the employee id and employee name of employees who do not have manager.*/


/*6. A. Display the names of all products of a particular subcategory 15 and the names of their vendors. */
select * from [Purchasing].[PurchaseOrderDetail];
select * from [Production].[ProductSubcategory];
select * from [Production].[ProductDescription];



/*B. Find the products that have more than one vendor. */



/*7. Find all the customers who do not belong to any store.*/

select * from [Sales].[Store];
select * from [Sales].[Customer];

select store.CustomerId
from [Sales].[Store] as store
join [Sales].[Customer] as customer
on store.CustomerID=customer.CustomerID
where store.Name= NULL;

/*8. Find sales prices of product 718 that are less than the list price recommended for that product.*/
select * from [Production].[Product];
select * from [Production].[ProductListPriceHistory];

select pro.Standardcost
from [Production].[Product] as pro
join [Production].[ProductListPriceHistory] as pri 
on pro.ProductID=pri.ProductID
where pro.productid=718 and pro.standardcost< pri.ListPrice;


/*9. Display product number, description and sales of each product in the year 2001. */

select * from [Sales].[SalesOrderHeader];

select * from [Sales].[SalesOrderDetail];
select * from [Production].[vProductAndDescription];
select * from [Production].[Product];


select salesord.ProductID,proddesc.Description,(salesord.OrderQty * salesord.UnitPrice) as SALES
from [Sales].[SalesOrderDetail] as salesord
join [Production].[vProductAndDescription] as proddesc
on salesord.ProductID=proddesc.ProductID
where year(salesord.ModifiedDate)=2001;


/*10. Build the logic on the above question to extract sales for each category by year. Fetch Product Name, Sales_2001, Sales_2002, Sales_2003.*/

select salesord.ProductID,proddesc.Description,(salesord.OrderQty * salesord.UnitPrice) as SALES,
case when year(salesord.ModifiedDate)= 2001 then '2001'
when year (salesord.ModifiedDate)= 2002 then '2002'
when year (salesord.ModifiedDate)= 2003 then '2003'
end as SalesYear
from [Sales].[SalesOrderDetail] as salesord
join [Production].[vProductAndDescription] as proddesc
on salesord.ProductID=proddesc.ProductID
where year(salesord.ModifiedDate)=2001;


/*Hint: For questions 9 & 10 (From Sales.SalesOrderHeader,sales.SalesOrderDetail, Production.Product.  Use ShipDate of SalesOrderHeader to extract shipped year.
Calculate sales using QTY and unitprice from SalesOrderDetail.)*/
