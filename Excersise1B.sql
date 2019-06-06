/*SQL Exercise 1B Database: Use the tables created in Exercise 1A*/

/*1. Calculate a price increase of 5 for all the titles and display them in a new column and
order them by maximum using the table Titles.*/

select price+ 5 as price_increase from titles4 
order by price_increase desc;

/*2. Display the stores that are situated in the state ‘WA’*/

select * from stores2 where state='WA';

/* 3. Display the store_id that provides least discount. */

select stor_id from discounts2 order by discounts;

/*4. Try to Update type from ‘Undecided’ to Null in the table Titles. And show the result/
error.*/
update titles4 set type_= 'NULL' where type='Undecided';
/* shows invalid column name as 'Undecided' */

/*5. Update Royalty to 20 in the table Titles, when the pub_date is between Jun 1991 and
Oct 1991.*/

update titles4 set Royalty=20 where pubdate between '1991/06/01' and '1991/10/01';

/*6. Increment lowqty by 2 when the discounttype is ‘Customer Discount’ and display that
as ‘Incremented lowqty’.*/

select lowqty+2 as increment_qty from dicounts2 where dicounttype='customerdiscount';

/*7. Display the title_id where lorange and hirange are greater than 1000.*/

select title_id from from royshed2  lorange>1000 and hirange>1000;

/*8. Display the Pulishers ID and Name who are not in USA.*/

select pub_id,pub_name from publishers2 where pub_name != 'USA';

/*9. Display the job Desc when ¼ of the Max_lvl is equal to min_lvl from the table Jobs.*/

select job_desc from job2 where (0.25* max_lvl)=min_lvl;

/*10. Display the Employee Fname and lname when minit = NULL*/
 
 select fname,lname from employee2 where minit= null;




