
DROP TABLE DIM_DW_SITE_T5_Padmanabh
create table DIM_DW_SITE_T5_Padmanabh
(
SITE_KEY int identity(1,1) primary key, 
SITE_ID NVARCHAR(100) NOT NULL,
SITE_NAME NVARCHAR(100) ,
SITE_TYPE_ID int ,
SITE_TYPE_NAME NVARCHAR(100) ,
PRIMARY_ADDRESS NVARCHAR(255) ,
PRIMARY_STATE NVARCHAR(50) ,
PRIMARY_COUNTRY NVARCHAR(50),
PRIMARY_REGION NVARCHAR(25) ,
SHIP_TO_ADDRESS NVARCHAR(255) ,
SHIP_TO_STATE NVARCHAR(50) ,
SHIP_TO_COUNTRY NVARCHAR(50) ,
SHIP_TO_REGION NVARCHAR(25) ,
CUSTOMER_ID NVARCHAR(100) ,
CUSTOMER_NAME NVARCHAR(100) ,
COMPLIANT_DATE NVARCHAR(50) ,
START_DATE DATE,
END_DATE DATE,
CURRENT_FLAG INT,
)

use imap
select * from [dbo].[TABLE_SITE]
select count(*),Type from [dbo].table_site group by type

select count(*) from [dbo].[TABLE_SITE]
use t5_padmanabh
select * from DIM_DW_SITE_T5_Padmanabh
select count(*) from DIM_DW_SITE_T5_Padmanabh
select count(*),site_Type_id from DIM_DW_SITE_T5_Padmanabh group by site_type_id




select * from imap.dbo.table_site

select count(*) from imap.dbo.table_site
group by objid
having count(*)>1

select count(*) from DIM_DW_SITE_T5_Padmanabh
group by site_id
having count(*)>1




INSERT INTO DIM_DW_SITE_T5_Padmanabh
select 
REPLACE(COALESCE(TS.SITE_ID,NULL,cast(TS.OBJID as varchar)),'NULL',cast(TS.OBJID as varchar)),
UPPER(COALESCE(TS.S_NAME,NULL,cast(TS.OBJID as varchar))),
COALESCE(TS.TYPE,null,-1),
COALESCE(TS.SITE_TYPE,null,'UNK'),
COALESCE(TA.Address,null,'UNK'),
COALESCE(TA.STATE,null,'UNK'),
iif(CHARINDEX('republic',TC.name)>0,SUBSTRING(TC.name, 1,CHARINDEX(' ', TC.name, 1) - 1),TC.name),
iif(len(TC.X_region)>4,SUBSTRING(RTRIM(TC.X_REgion),1,1)+SUBSTRING(TC.X_REGION,(charindex(' ',TC.X_REGION)),2),TC.X_REGION),
COALESCE(TAA.S_ADDRESS,null,'UNK'),
COALESCE(TAA.S_STATE,null,'UNK'),
iif(CHARINDEX('republic',TC.S_name)>0,SUBSTRING(TC.S_name, 1,CHARINDEX(' ', TC.S_name, 1) - 1),TC.S_name),
TS.S_REGION,
REPLACE(COALESCE(TBO.S_ORG_ID,NULL,cast(TBO.OBJID as varchar)),'NULL',cast(TBO.OBJID as varchar)),
iif(CHARINDEX('INC',TBO.name)>0,replace(TBO.NAME,'INC','INCORPORATE'),TBO.name),
CONVERT(VARCHAR,TC.X_COMPLIANT_DATE,7),
getdate(),
getdate(),
1
from IMAP.[dbo].[TABLE_SITE] as TS
left join IMAP.[dbo].[TABLE_ADDRESS] as TA
on TS.CUST_PRIMADDR2ADDRESS = TA.OBJID 
left join IMAP.[dbo].[TABLE_COUNTRY] TC
on TA.ADDRESS2COUNTRY=TC.OBJID and TS.CUST_PRIMADDR2ADDRESS = TA.OBJID 
left join IMAP.[dbo].[TABLE_ADDRESS] as TAA
ON TS.CUST_SHIPADDR2ADDRESS = TAA.OBJID
left join IMAP.[dbo].[TABLE_BUS_ORG] as TBO
on TS.PRIMARY2BUS_ORG = TBO.objid



