/*1. Create the tables with the mentioned constraints and name the tables appropriately
with your emp_id appended. */

create table discounts2 (
discounttype Varchar(25),	
stor_id	Int, /*Foreign key references stores1(stor_id),*/
lowqty	Int,
highqty	Int,
discount float);


create table stores2 (
stor_id	int primary key,
stor_name	varchar(255),
stor_address varchar(255),	
city varchar(25),
state varchar(5),	
zip  int);


create table Sales2 (
stor_id	int /*Foreign key references stores1(stor_id)*/,
ord_num	varchar(15),
ord_date datetime,	
qty	int,
payterms varchar(25),	
title_id varchar(10)); /*foreign key references Titles1(title_id));*/


create table Authors2 (
au_id varchar(25) primary key,
au_lname varchar(25),	
au_fname varchar(25),
phone	varchar (25),
address	varchar (255),
city varchar (25),
state varchar (5),
zip	int,
contract bit);


create table titles4 (
title_id varchar(255) primary key,
title varchar(255),
type_ varchar(255),
pub_id int, /*foreign key references Publishers1(pub_id),*/
price float,
advance int,
royalty int,
ytd_sales int,
notes varchar(255),
pubdate datetime);


create table TitleAuthors2(
au_id varchar(25), /*foreign key references authors1(au_id),*/
title_id varchar(10),/*  foreign key references Titles1(title_id),*/
au_ord	int,
royaltyper int);


create table Royshed2 (
title_id varchar(10), /*foreign key references Titles1(title_id),*/
lorange	int,
hirange	int,
royalty int);


create table Publishers2 (
pub_id	int primary key,
pub_name varchar(50),	
city varchar(50),	
state varchar(5),	
country varchar(25));


create table Pub_Info2 (
pub_id int, /*foreign key references Publishers1 (pub_id),*/
logo varchar(max),
pr_info varchar (255));


create table Employee2 (
emp_id varchar(25) primary key,
fname varchar(50),
minit varchar(1),
lname varchar(50),
job_id int, /*foreign key references jobs1(job_id),*/
job_lvl int,/*check (job_lvl>min_lvl and job_lvl<max_lvl)*/
pub_id int, /*foreign key references Publishers1 (pub_id),*/
hire_date datetime);


create table jobs2 (
job_id	int primary key,
job_desc varchar(50),	
min_lvl	int,
max_lvl int,
Job_Code int);

/* 2.a. Insert the First Row of stores table into the table without the columns specied in the
insert clause.*/
insert into stores2 values (6380,'Eric the Read Books','788 Catamaugus Ave.','Seattle','WA',98056);

/*b. Insert the Second Row of stores Table into the table with the columns specied in the
insert clause explicitly and conrm the data inserted. */

insert into stores2 (stor_id,stor_name,stor_address,city,state,zip) values (7066,'Barnum"s','567 Pasadena Ave.','Tustin','CA',92789);
select * from stores2;
update stores1 set stor_name='Barnum''s' where stor_id=7066;

/*c. Insert all other rows into Stores table as it is in the table output*/
insert into stores2 values (7067,'News & Brews','577 First St.','Los Gatos','CA',96745),(7131,'Doc-U-Mat: Quality Laundry and Books','24-A Avrogado Way','Remulade','WA',98014),
(7896,'Fricative Bookshop','89 Madison St.','Fremont','CA',90019),(8042,'Bookbeat','79 Carson St.','Portland','OR',89076);

/*3. Insert the data into all the tables using the data in the excel sheet attached.*/
Insert into discounts2 values ('Initial Customer',6380,110,NULL,10.5),('Volume Discount',7131,100,1000,6.7),
('Customer Discount',8042,23,NULL,5);


insert into Publishers2 values 
(736,'New Moon Books','Boston','MA','USA'),(877,'Binnet & Hardley','Washington','DC','USA'),
(1389,'Algodata Infosystems','Berkeley','CA','USA'),(1622,'Five Lakes Publishing','Chicago','IL','USA'),
(1756,'Ramona Publishers','Dallas','TX','USA'),(9901,'GGG&G','Mï¿½nchen',NULL,'Germany'),
(9952,'Scootney Books','New York','NY','USA'),(9999,'Lucerne Publishing','Paris',NULL,'France');


insert into Pub_info2 values
(736,'Newmoon.bmp','This is sample text data for New Moon Books'),
(877,'Binnet.bmp','This is sample text data for Binnet & Hardley'),
(1389,'Algodata.bmp','This is sample text data for Algodata Infosystems'),
(1622,'5lakes.bmp','This is sample text data for Five Lakes Publishing'),
(1756,'Ramona.bmp','This is sample text data for Ramona Publishers'),
(9901,'Gggg.bmp','This is sample text data for GGG&G'),
(9952,'Scootney.bmp','This is sample text data for Scootney Books'),
(9999,'Lucerne.bmp','This is sample text data for Lucerne Publishing');


insert into jobs2 values
(1,'New Hire - Job not specified',10,10,1120),
(2,'Chief Executive Officer',200,250,1122),
(3,'Business Operations Manager',175,225,1125),
(4,	'Chief Financial Officer',175,250,1126),
(5,'Publisher',150,250,1145),
(6,'Managing Editor',140,225,1102),
(7,'Marketing Manager',120,200,1245),
(8,	'Public Relations Manager',100,175,1458),
(9,	'Acquisitions Manager',75,175,1265),
(10,'Productions Manager',75,165,1258),
(11,'Operations Manager',75,150,4789),
(12,'Editor',25,100,1258),
(13,'Sales Representative',25,100,2033),
(14,'Designer',25,100,1025);


insert into employee2 values
('PMA42628M','Paolo','M','Accorti',13,35,877,'Aug 27 1992 12:00AM'),
('PSA89086M','Pedro','S','Alfonso',14,89,1389,'Dec 24 1990 12:00AM'),
('VPA30890F','Victoria','P','Ashworth',6,140,877,'Sep 13 1990 12:00AM'),
('H-B39728F','Helen',NULL,'Bennett',12,35,877,'Sep 21 1989 12:00AM'),
('L-B31947F','Lesley',NULL,'Brown',7,120,877,'Feb 13 1991 12:00AM'),
('F-C16315M','Francisco',NULL,'Chang',4,227,9952,'Nov 3 1990 12:00AM'),
('PTC11962M','Philip','T','Cramer',2,215,9952,'Nov 11 1989 12:00AM'),
('A-C71970F','Aria',NULL,'Cruz',10,87,1389,'Oct 26 1991 12:00AM'),
('AMD15433F','Ann',	'M','Devon',3,200,9952,'Jul 16 1991 12:00AM'),
('ARD36773F','Anabela',	'R','Domingues',8,100,877,'Jan 27 1993 12:00AM'),
('PHF38899M','Peter','H','Franken',10,75,877,'May 17 1992 12:00AM'),
('PXH22250M','Paul','X','Henriot',5,159,877,'Aug 19 1993 12:00AM'),
('CFH28514M','Carlos','F','Hernï¿½ndez',5,211,9999,'Apr 21 1989 12:00AM'),
('PDI47470M','Palle','D','Ibsen',7,195,736,'May 9 1993 12:00AM'),
('KJJ92907F','Karla','J','Jablonski',9,170,9999,'Mar 11 1994 12:00AM'),
('KFJ64308F','Karin','F','Josephs',14,100,736,'Oct 17 1992 12:00AM');

/* RECTIFIED*/
insert into titles4 values
('MC3021','The Gourmet Microwave','mod_cook',877,2.99,15,0,24,'22246 Traditional French gourmet recipes adapted for modern microwave cooking.','Jun 18 1991 12:00AM');
insert into titles4 values
('MC3026','The Psychology of Computer Cooking','UNDECIDED',877,NULL,NULL,NULL,NULL,NULL,'Apr 28 1995 10:36AM');
insert into titles4 values
('PC1035','But Is It User Friendly?','popular_comp',1389,22.95,7,0,16,'8780 A survey of software for the naive user	 focusing on the friendliness of each.','Jun 30 1991 12:00AM');
insert into titles4 values
('PC8888','Secrets of Silicon Valley','popular_comp',1389,20,8,0,10,'4095 Muckraking reporting on the world''s largest computer hardware and software manufacturers.','Jun 12 1994 12:00AM');
insert into titles4 values
('PC9999','Net Etiquette','popular_comp',1389,NULL,NULL,NULL,NULL,'A must-read for computer conferencing.','Apr 28 1995 10:36AM');
insert into titles4 values
('PS1372','Computer Phobic and Non-Phobic Individuals: Behavior Variations','psychology',877,21.59,7,0,10,'375A must for the specialist examining the difference between those who hate and fear computers and those who don''t.','Oct 21 1991 12:00AM');
insert into titles4 values
('BU1032','The Busy Executive''s Database Guide','business',1389,19.99,5,0,10,'4095 An overview of available database systems with emphasis on common business applications. Illustrated.','Jun 12 1991 12:00AM');
insert into titles4 values
('BU1111','Cooking with Computers: Surreptitious Balance Sheets','business',1389,11.95,5,0,10,'3876 Helpful hints on how to use your electronic resources to the best advantage.','Jun 9 1991 12:00AM');
insert into titles4 values
('BU2075','You Can Combat Computer Stress!','business',736,2.99,10,125,24,'18722 The latest medical and psychological techniques for living with the electronic office. Easy-to-understand explanations.','Jun 30 1991 12:00AM');
insert into titles4 values
('BU7832','Straight Talk About Computers','business',1389,19.99,5,0,10,'4095 Annotated analysis of what computers can do for you: a no-hype guide for the critical user.','Jun 22 1991 12:00AM');
insert into titles4 values
('MC2222','Silicon Valley Gastronomic Treats','mod_cook',877,19.99,0,12,NULL,'2032 Favorite recipes for quick	 easy	 and elegant meals.','Jun 9 1991 12:00AM');
	



select * from Titles1;

insert into Authors2 values
('172-32-1176','White','Johnson','408 496-7223','10932 Bigge Rd.','Menlo Park','CA',94025,1),
('213-46-8915','Green','Marjorie','415 986-7020','309 63rd St. #411','Oakland','CA',94618,1),
('238-95-7766','Carson','Cheryl','415 548-7723','589 Darwin Ln.','Berkeley','CA',94705,1),
('267-41-2394','OLeary','Michael','408 286-2428','22 Cleveland Av. #14,','San Jose','CA',95128,1),
('274-80-9391','Straight','Dean','415 834-2919',	'5420 College Av.','Oakland','CA',94609,1),
('341-22-1782','Smith','Meander','913 843-0462','10 Mississippi Dr.','Lawrence','KS',66044,0),
('409-56-7008','Bennet','Abraham','415 658-9932','6223 Bateman St.','Berkeley','CA',94705,1),
('427-17-2319','Dull','Ann','415 836-7128','3410 Blonde St.','Palo Alto','CA',94301,1),
('472-27-2349','Gringlesby','Burt','707 938-6445','PO Box 792','Covelo','CA',95428,1),
('486-29-1786','Locksley','Charlene','415 585-4620','18 Broadway Av.','San Francisco','CA',94130,1);




insert into TitleAuthors2 values
('172-32-1176','PS3333',1,100),('213-46-8915','BU1032',2,40),('213-46-8915','BU2075',1,100),
('238-95-7766','PC1035',1,100),('267-41-2394','BU1111',2,40),('267-41-2394','TC7777',2,30),
('274-80-9391',	'BU7832',1,100),('409-56-7008',	'BU1032',1,60),('427-17-2319',	'PC8888',1,50),
('472-27-2349',	'TC7777',3,30),('486-29-1786',	'PC9999',1,100),('486-29-1786',	'PS7777',1,100),
('648-92-1872',	'TC4203',1,100),('672-71-3249',	'TC7777',1,40),('712-45-1867',	'MC2222',1,100),
('722-51-5454',	'MC3021',1,75);


Insert into sales2 values
(6380,'6871','Sep 14 1994 12:00AM',5,'Net 60','BU1032'),
(6380,'722a','Sep 13 1994 12:00AM',3,'Net 60','PS2091'),
(7066,'A2976','May 24 1993 12:00AM',50,'Net 30','PC8888'),
(7066,'QA7442.3','Sep 13 1994 12:00AM',75,'ON invoice','PS2091'),
(7067,'D4482','Sep 14 1994 12:00AM',10,'Net 60','PS2091'),
(7067,'P2121','Jun 15 1992 12:00AM',40,'Net 30','TC3218'),
(7067,'P2121','Jun 15 1992 12:00AM',20,'Net 30','TC4203'),
(7067,'P2121','Jun 15 1992 12:00AM',20,'Net 30','TC7777'),
(7131,'N914008'	,'Sep 14 1994 12:00AM',20,'Net 30','PS2091'),
(7131,'N914014','Sep 14 1994 12:00AM',25,'Net 30','MC3021'),
(7131,'P3087a','May 29 1993 12:00AM',20,'Net 60','PS1372'),
(7131,'P3087a','May 29 1993 12:00AM',25,'Net 60','PS2106'),
(7131,'P3087a','May 29 1993 12:00AM',15,'Net 60','PS3333'),
(7131,'P3087a','May 29 1993 12:00AM',25,'Net 60','PS7777'),
(7896,'QQ2299','Oct 28 1993 12:00AM',15,'Net 60','BU7832'),
(7896,'TQ456','Dec 12 1993 12:00AM',10,'Net 60','MC2222'),
(7896,'X999','Feb 21 1993 12:00AM',35,'ON invoice','BU2075'),
(8042,'423LL922','Sep 14 1994 12:00AM',15,'ON invoice','MC3021'),
(8042,'423LL930','Sep 14 1994 12:00AM',10,'ON invoice','BU1032'),
(8042,'P723','Mar 11 1993 12:00AM',25,'Net 30','BU1111'),
(8042,'QA879.1','May 22 1993 12:00AM',30,'Net 30','PC1035');

/* Values for Royshed */

insert into Royshed2 values
('BU1032',0,5000,10),
('BU1032',5001,50000,12),
('PC1035',0,2000,10),
('PC1035',2001,3000,12),
('PC1035',3001,4000,14),
('PC1035',4001,10000,16),
('PC1035',10001,50000,18),
('BU2075',0,1000,10),
('BU2075',1001,3000,12),
('BU2075',3001,5000,14),
('BU2075',5001,7000,16),
('BU2075',7001,10000,18),
('BU2075',10001,12000,20),
('BU2075',12001,14000,22),
('BU2075',14001,50000,24),
('PS2091',0,1000,10),
('PS2091',1001,5000,12),
('PS2091',5001,10000,14),
('PS2091',10001,50000,16),
('PS2106',0,2000,10),
('PS2106',2001,5000,12),
('PS2106',5001,10000,14),
('PS2106',10001,50000,16),
('MC3021',0,1000,10),
('MC3021',1001,2000,12),
('MC3021',2001,4000,14),
('MC3021',4001,6000,16),
('MC3021',6001,8000,18),
('MC3021',8001,10000,20),
('MC3021',10001,12000,22),
('MC3021',12001,50000,24),
('TC3218',0,2000,10),
('TC3218',2001,4000,12),
('TC3218',4001,6000,14),
('TC3218',6001,8000,16),
('TC3218',8001,10000,18),
('TC3218',10001,12000,20),
('TC3218',12001,14000,22),
('TC3218',14001,50000,24),
('PC8888',0,5000,10),
('PC8888',5001,10000,12),
('PC8888',10001,15000,14),
('PC8888',15001,50000,16),
('PS7777',0,5000,10),
('PS7777',5001,50000,12),
('PS3333',0,5000,10),
('PS3333',5001,10000,12),
('PS3333',10001,15000,14),
('PS3333',15001,50000,16),
('BU1111',0,4000,10),
('BU1111',4001,8000,12),
('BU1111',8001,10000,14),
('BU1111',12001,16000,16),
('BU1111',16001,20000,18),
('BU1111',20001,24000,20),
('BU1111',24001,28000,22),
('BU1111',28001,50000,24),
('MC2222',0,2000,10),
('MC2222',2001,4000,12),
('MC2222',4001,8000,14),
('MC2222',8001,12000,16),
('MC2222',12001,20000,18),
('MC2222',20001,50000,20),
('TC7777',0,5000,10),
('TC7777',5001,15000,12),
('TC7777',15001,50000,14),
('TC4203',0,2000,10),
('TC4203',2001,8000,12),
('TC4203',8001,16000,14),
('TC4203',16001,24000,16),
('TC4203',24001,32000,18),
('TC4203',32001,40000,20),
('TC4203',40001,50000,22),
('BU7832',0,5000,10),
('BU7832',5001,10000,12),
('BU7832',10001,15000,14),
('BU7832',15001,20000,16),
('BU7832',20001,25000,18),
('BU7832',25001,30000,20),
('BU7832',30001,35000,22),
('BU7832',35001,50000,24),
('PS1372',0,10000,10),
('PS1372',10001,20000,12),
('PS1372',20001,30000,14),
('PS1372',30001,40000,16),
('PS1372',40001,50000,18);


/*4. Update column lorange in the table Royshed from 0 to 100 */

update Royshed set lorange=100 where lorange=0;

/*5. Update au_ord from 2 to 1 when the title_id is ‘BU1111’ and ‘TC7777’ in the table
TitleAuthors.*/

update TitleAuthors1 set au_ord=1 where title_id='BU111' and title_id='TC7777';

/*6. Try inserting Null into column Discount Type in the table Discounts. Display the error
message.*/
update Dicounts set discounttype=NULL where discounttype!=NULL;

/*7. Check all the constraints are working by inserting sample data and show the result
set.*/


/*8. Create a table Jobs_Dup and perform the following.

a. Delete the jobs that have min_lvl as 175 
b. Delete the jobs whose job_desc is publisher and Editor.
c. Delete the records from Jobs_Dup */
select * into jobs_dup from jobs1;

delete from jobs_dump
where min_lvl=175;

delete from jobs_dump 
where job_desc in ('publisher','editor')

delete from jobs_dump; 


/*9. Display the employee first name and lastname who were hired after 1992*/

select fname,lname from employees1 where year (hiredate) > 1992;

/*10. Display the titles that were published between Jun 1991 and Jun 1994*/

select titles from Titles1 where pub_date between '1991-06-01' and'1994-06-01';




















