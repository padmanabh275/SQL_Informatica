use T5_padmanabh
/*Table Structure
Flights(flno: integer, from: string, to: string, distance: integer, departs:
time,
arrives: time, price: integer)
Aircraft(aid: integer, aname: string, cruisingrange: integer)
Certified(eid: integer, aid: integer)
Employees(eid: integer, ename: string, salary: integer)*/

CREATE TABLE [dbo].[Flights](
	[flno] [varchar](25) ,
	[frm] [varchar](70) ,
	[arr_to] [varchar](70) ,
	[distance] [int] ,
	[departs] [datetime],
	[arrives] [datetime] ,
	[price] [int] 
)

CREATE TABLE [dbo].[Aircraft](
	[aid] [int] ,
	[aname] [varchar](50) ,
	[cruisingrange] [int] 
)

CREATE TABLE [dbo].[Certified](
	[eid] [int] ,
	[aid] [int] 
)

CREATE TABLE [dbo].[Employees](
	[eid] [int] NULL,
	[ename] [varchar](60) ,
	[salary] [int] 
)

insert into Aircraft values( 1,'Trans Anguilla Air',456689)


insert into Aircraft values( 5,'REDjet',8756689)


insert into Aircraft values( 8,'Fly BVI',56689)

insert into Aircraft values( 11,'International AirLink',9089)
insert into Aircraft values( 3,'M&N Aviation',432109)
insert into Employees values(101, 'CHRISTOPHER',57000)

insert into Employees values(335, 'EDWARD',115000 )

insert into Employees values(670, 'MATTHEW',115000 )


insert into Employees values(120,'ERIC', 10000)

insert into Employees values(225, 'DOUGLAS', 23000)

insert into Certified values (101,5)

insert into Certified values(335,11)

insert into Certified values(670,5)

insert into Certified values (120,11)

insert into Certified values(225,5)

insert into Flights values('RUS 1727','Los Angeles','Honolulu',180, '14:30','16:30',2000) 

insert into Flights values('LH 4234', 'New York' , 'Madison', 190,'11:38','14:33',1888) 

insert into Flights values('TP 559', 'Madison' , 'New York',230,'10:23','14:39',2500) 

insert into Flights values('LH 1704', 'Los Angeles', 'NewYork', 145,'9:30','12:54', 3020) 

insert into Flights values('UA 882', 'Utah' ,'Seattle',87,'13:20','15:40',1200) 

insert into FLights values('AI 512', 'Seattle', 'Chicago',123,'12:35','16:30',2500) 

insert into Flights values('TAA 432','Washington', 'Sans Fransisco',230,'8:44','12:00',3200) 

insert into Flights values('LH 4234', 'Detriot', 'Los angeles',156,'11:56','15:40',2200) 

insert into Flights values('RJ 1235','Sans Fransisco','Detriot',102,'11:30','16:30',900) 

insert into Flights values('LH 4234','Chicago','NewYork',169,'02:33','05:30',1400) 

insert into Flights values('LH 4234','Sans Fransisco','Chicago',83,'15:20','18:40',900) 

insert into Flights values('LH 4234','Washington','Detriot',78,'5:30','10:23',1300)

/* 1 A customer wants to travel from Madison to New York with no more then two changes in flight. 
list the choice of departure times from madison if the customer wants to arrive in 
new york by 6 pm.*/

select * from aircraft
select * from flights
select * from certified
select * from employees

select * 
from flights
where frm='Madison' and arr_to = 'New York' and arrives<'18:00'

select * from Flights where frm='Madison' and arrives between '10:00:00' and '18:00:00'and (arr_to='New York' or arr_to='NewYork')


/* 2 identify the routs that can be piloted by every pilot who makes more then $100000*/

select distinct emp.ename,fli.flno,fli.frm,fli.arr_to
from flights as fli,employees as emp
join certified as certi on
emp.eid=certi.eid
join aircraft as air on  				
air.aid=certi.aid
where emp.salary>100000
group by emp.ename,fli.frm,fli.arr_to,fli.flno


/* 3 find the names of the aircraft such that all pilots certified to operate them 
earn more then $80000 */
select * from aircraft
select * from flights
select * from certified
select * from employees

select distinct air.aname
from flights as fli,employees as emp
join certified as certi on
emp.eid=certi.eid
join aircraft as air on  				
air.aid=certi.aid
where emp.eid in (select eid from employees where salary>80000)


/* 4 For all aircraft with a crushing range over 1000 miles,find the name of the aircraft
and the average salary of all the pilots certified to the aircraft */


select distinct air.aname,avg (emp.salary)
from flights as fli,employees as emp
join certified as certi on
emp.eid=certi.eid
join aircraft as air on  				
air.aid=certi.aid
where air.cruisingrange>=1000
group by air.aname


/*---Junctions table structure: */
CREATE TABLE junctions (
[JuncNo] INTEGER,
[TrafficLight] INTEGER,
[JuncName] varchar(50));


---Roads table structure: 
CREATE TABLE roads (
[link_id] INTEGER,
[FJunc] INTEGER,
[TJunc] INTEGER,
[roadname] varchar(60),
[link_len] decimal(10,3),
[cityname] varchar(60),
[zipcode] varchar(12));


insert into roads
(link_id,fjunc,tjunc,roadname,link_len,cityname,zipcode)
values
(112,18,8 ,'Archibald St' ,29.39 ,'Hatsfield','56349')
,(113,8,19 ,'Archibald St' ,34.56 ,'Hatsfield','56349')
,(119,30,12 ,'Factory Yard' ,157.48 ,'Hatsfield','56349')
,(122,7,8 ,'High Amplitude Avenue',31.30 ,'Hatsfield','56349')
,(117,18,20, 'Archibald St' ,51.34,'Hatsfield','56349')
,(120,20,6, 'South west st.' ,94.45,'Hatsfield','56349')
,(116,16,11, 'Morington Avenue' ,12.42,'Hatsfield','56349')
,(111,11,13, 'Morington Avenue' ,10.23,'Hatsfield','56349')
,(190,13,23, 'Morington Avenue' ,23.67,'Hatsfield','56349')
,(191,11,12, 'Factory Yard' ,11.23,'Hatsfield','56349')
,(194,14,12, 'Clinton street' ,31.23,'Hatsfield','56349')
,(144,20,23, 'Mossern street' ,31.23,'Hatsfield','56349')
,(145,26,23, 'Walker Avenue' ,22.53,'Hatsfield','56349')


insert into junctions
(JuncNo,TrafficLight,JuncName)
values
(8,1,'JN001')
,(10,0,'JN008')
,(11,0,'JN089')
,(12,0,'JN034')

select * from roads
select * from junctions

/* 1. what is the longest/street road in this layout */

select ro.roadname,ro.link_len
from roads as ro
join junctions as jo on 
ro.Fjunc=jo.JuncNo or ro.Tjunc=jo.JuncNo
where ro.link_len in (select max(link_len) from roads)
group by ro.roadname,ro.link_len
order by sum(ro.link_len) desc

select top 1 sum(ro.link_len), ro.roadname
from roads as ro 
group by ro.roadname
order by sum(ro.link_len) desc

/* 2. Does the two streets intersects ("Archibald St" & "High Amplitute Avenue")*/
select distinct jo.JuncName,ro.link_id,ro.roadname
from roads as ro
join junctions as jo on 
ro.Fjunc=jo.JuncNo or ro.Tjunc=jo.JuncNo
where ro.roadname='Archibald St' or ro.roadname='High Amplitute Avenue'
group by Jo.JuncName,ro.link_id,ro.roadname


/*jo.JuncNo in (select TJunc from roads) */


/* 3 Does this layout include any pseudo junction? Please find them  any juction in between is not needed as same route*/
select * from roads
select * from junctions

select jo.JuncName,ro.link_id,ro.roadname
from roads as ro
join junctions as jo on 
ro.Fjunc=jo.JuncNo or ro.Tjunc=jo.JuncNo
where ro.link_id is not null


 
 select (len(roadname) - len(replace(roadname,'o',''))) from roads 
 where roadname='Morington Avenue'