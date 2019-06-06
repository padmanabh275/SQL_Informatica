Create Table Item_sub (
Items_id Int primary key,
Items_sub_desc Varchar(25) NOT NULL,
Item_expiry_date Date,
Item_creation_date Date, 
Amount Int check (Amount>0),
);
Create Table Dept (
Dept_id Int primary key,
Dept_Desc Varchar(25) NOT NULL,
);
Create Table Makers(
Maker_id Int primary key, 
Maker_Name Varchar(25) NOT NULL,
Maker_city Varchar(25),
Maker_address Varchar(25),
Maker_pincode Varchar(25),
Maker_phone Varchar(25)
);
Create Table Items (
Item_id Int primary key, 
Item_desc varchar(25) NOT NULL, 
Item_sub_id Int Foreign key references Item_sub(Items_id),
Quantity int,
Item_code Varchar(25) unique, 
Item_dept_id Int Foreign key references Dept (Dept_id), 
Item_Maker_id Int Foreign key references Makers(Maker_id), 
Booked_Date Date);

Insert into Item_sub (Items_id,Items_sub_desc,Item_expiry_date,Item_creation_date,Amount) values 
(50,'Cif','01/01/13','01/01/12',100),(51,'Kele','01/01/13','01/01/12',50),(60,'Borbon','01/12/14','01/12/11',200),
(61,'Milk Biscuits','01/12/13','01/11/11',200),(70,'Pepsi','01/01/14','01/01/10',50);

Insert into Dept (Dept_id,Dept_Desc) values (1000,'Toileteries'),(1001,'Eateries');

Insert into Makers (Maker_id,Maker_Name,Maker_city,Maker_address,Maker_pincode,Maker_phone) values
(1,'Roda','Mumbai','57,North Road',600057,37620927),(2,'Maríe','Chennai','23,East Road',600025,43392028),
(3,'PepsiCo','Delhi','12,1st Cross St',600021,91-9962567999),(4,'Dove','Delhi','13,North Road',2738,NULL),	
(5,'Roda_A','Simla','787,West',13454,NULL)	


Insert into Items (Item_id,Item_desc,Item_sub_id,Quantity,Item_code,Item_dept_id,Item_Maker_id,Booked_Date) values
(100,'Soap Liquids',50,2,'PRO100',1000,1,'01/01/12'),(100,'Soap Liquids',50,3,'PRO100',1000,1,'02/01/12'),
(101,'Biscuits',60,1,'PRO101',1001,2,'01/12/11'),(102,'Drinks',70,4,'102DR',1001,3,'01/10/11'),
(103,'Soap Liquids',51,1,'PRO103',1000,4,'01/04/12'),(104,'Biscuits',61,1,'PRO104',1001,2,'01/03/09')
/* Primary key can't have duplicates so there is an error  */


/* 2.a Insert the First Row of Item table into the table without the columns specied in
the insert clause.*/

Insert into Items Values (100,'Soap Liquids',50,2,'pro100',1000,1,'01/01/2012');

/* 2.b Insert the Second Row of Item Table into the table with the columns specied in
the insert clause explicitly and conrm the data inserted.  */

Insert into Items (Item_id,Item_desc,Item_sub_id,Quantity,Item_code,Item_dept_id,Item_Maker_id,Booked_Date) values 
(100,'Soap Liquids',50,3,'PRO100',1000,1,'02/01/12');
/* Primary key can't have duplicates so there is an error  */

/*2.c Insert the third row, fourth row and Fifth of items table as it is in the table output */

Insert into Items Values (101,'Biscuits',60,1,'PRO101',1001,2,'01/12/11'),(102,'Drinks',70,4,'102DR',1001,3,'01/10/11'),
(103,'Soap Liquids',51,1,'PRO103',1000,4,'01/04/12');


/*2.d Update the Item Code for the Item Id 102 to PRO102. */

update items set item_code='pro102' where item_id=102;


/*2.e Select the Id and desc and maker id of all the items*/

select Item_id,Item_desc,Item_Maker_id from Items;

/*2.f Select the Id , ItemDesc where the quantity is more than 2*/

select Item_id,item_desc from items where quantity>2;

/*2.g Calculate a Quantity increase of 5 for all the items and display them in a new
column and order them by maximum. */

select *,quantity+5 as qty from items order by qty desc; 

/* 2.h Calculate the Monthly Gross Quantity along with 5 quantity added to all the item
(for example for Item id 100, the qty is 2 for Jan 01, aft qty added is 7, the qty for Jan 02 is 3,
aft qty added is 8, so monthly gross for Jan is 15) in a separate column with the tile Monthly
Gross */
select * from items;
select  sum (quantity+5) as monthly_gross from items group by month(booked_date);

/*concat(month(booked_date),' ',year(booked_date)) month ,sum(qty) from (select item_id,booked_date,quantity+5 as qty from items); */

/*2.i Display all the items that are brought in 2009*/
select * from items where year (booked_date)=2009;

/* The record is not entered in the system so it wont display. */

/*2.j Display the items that are brought between 1 Jun 2011 and 1 Dec 2012*/

select * from items where year (booked_date) between 2011 and 2012
 and month (booked_date) between 01 and 12
 and day (booked_date) between 01 and 31 ;

/*2.k Display the Items that are made by maker Id 2 and the booked date between Jan
2010 and Dec 2011 */

select maker_id=2 from items where year (booked_date) between 2011 and 2012
 and month (booked_date) between 01 and 12
 and day (booked_date) between 01 and 31 ;


/*2.l Display all the item_id,items_desc based on the latest booked date order.*/

select item_id,item_desc from items order by booked_date desc;

/* 2.m Check all the constraints are working (Include screenshots) */

/* 2.n Create a table 'items_dup' from 'Items' and perform the following below 
Delete the Items that are belonging to Maker Id 2 from the table items_dup
Delete the Items that are belonging to the Year 2012
Delete the records from items_dup*/

select * into item_dumps from items;
select * from item_dumps;
delete from item_dumps where Item_Maker_id=2;
delete from item_dumps where year (booked_date)=2012;
delete  from item_dumps; 