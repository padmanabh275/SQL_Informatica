use adventureworks;
declare @productid int;
declare @name nvarchar(25);
declare products cursor fast_forward for
select productid,name from production.product;
open products;
fetch next from products into @productid, @name;
while @@fetch_status=0
begin 
print @productid;
print @name;
fetch next from products into @productid,@name;
end 
close products;
deallocate products;
