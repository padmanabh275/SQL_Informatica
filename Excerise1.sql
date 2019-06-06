use northwind;

select * 
into T5_Padmanabh.dbo.SRC_Customer
from customers 
where 1=1 

-- create 4 target tbls 
--1)customer_scd1 (tracking column -customer phone)
--2)customer-scd2 (tracking column - zipcode)

use T5_Padmanabh

SELECT * INTO customer_scd2 FROM SRC_Customer where 1=1
SELECT * INTO customer_scd3 FROM SRC_Customer where 1=1
select * into customer_scd1 from SRC_Customer where 1=1

select * from SRC_Customer
select * from customer_scd1
--1
update SRC_Customer
set Phone= 12121
where CustomerID='BERGS'


--update row_number()customer_scd1

update customer_scd1
set Phone=(source.Phone)
from SRC_Customer as source
join customer_scd1 as cust on source.CustomerID=cust.CustomerID
where  source.Phone != cust.Phone 
insert into customer_scd1 values ('AKKKK','Royal Motors','Avengers','Endgame','Wanko','dream','we','1AA','Waikato',232322,23232)

Insert into customer_scd1 select cust.* from SRC_Customer as source
left join customer_scd1 as cust on source.CustomerID=cust.CustomerID
where source.CustomerID is Null

/*Insert into SRC_Customer select source.* from customer_scd1 as source
left join SRC_Customer as cust on source.CustomerID=cust.CustomerID
where cust.CustomerID is null*/

--2 
alter table customer_scd2
	add start_dt datetime,
	end_dt datetime,
	flag int,
	volume int
select * from customer_scd2
update customer_scd2
set start_dt= getdate()
set end_dt= getdate()+1
set flag=0
set volume=1

--



.where customer_scd2.flag is null

select * from customer_scd2
--insert into customer_scd2 values ('AKKKK','Royal Motors','Avengers','Endgame','Wanko','dream','we','1AA','Waikato',232322,23232)
merge into customer_scd2 source
using (select SRC_Customer.PostalCode)
from SRC_Customer as target1
on (target1.CustomerID=source.CustomerID) and (target1.Postalcode != source.Postalcode)
when matched then 
	update set PostalCode =target1.PostalCode
	update customer_scd2
		set start_dt= getdate()
		set end_dt= getdate()+1
		set flag=0
		set volume=1
when not matched then 
insert (source.CustomerName,source.CompanyName,source.ContactName,source.ContactTitle,source.Address,source.City,source.Region,
source.PostalCode,source.Country,source.Phone,source.Fax,source.start_dt,source.end_dt,source.flag,source.volume
values ()
 


-- Customer_scd3(tracking column - Region )

SELECT * INTO customer_scd3 FROM SRC_Customer where 1=1

select * from SRC_Customer

merge into customer_scd3 source
using (select SRC_Customer.Region)
from SRC_Customer as target1
on (target1.Region=source.Region)
when matched and target1.Region !=source.Region then
		update SRC_Cusomer
		set flag=0
		set end_dt=getdate()
when not matched then 
	insert (source.CustomerName,source.CompanyName,source.ContactName,source.ContactTitle,source.Address,source.City,source.Region,
	source.PostalCode,source.Country,source.Phone,source.Fax,source.start_dt,source.end_dt,source.flag,source.volume
values ()


--4) Incremental load - Customer_INC1(incermental load)
SELECT * INTO customer_inc1 FROM SRC_Customer where 1=1
 alter table customer_inc1
	add Auto_1 int  not null identity (1,1)
