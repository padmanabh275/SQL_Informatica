/* Work shop 4*/

use airport;

/* 1 Find the names of different passengers , who flew more then once on the same seat */
--result name,place,no of trips
select * from [dbo].[Trip]
select * from  [Pass_in_trip][dbo]
select * from  [dbo].[Company][dbo]
select * from [dbo].[Passenger]


select pass.Name,count(Pass_Trip.place) as Place,count(trip.trip_no) as No_of_Trips
from Trip as trip 
join Pass_in_trip as Pass_Trip on 
Trip.trip_no=Pass_Trip.trip_no
join Company as comp on 
comp.ID_comp=trip.ID_comp
join Passenger as pass on 
Pass_Trip.ID_psg=pass.ID_psg
--where Pass_Trip.ID_psg in (select sum(place) from Pass_in_Trip) 
group by pass.Name


/*2 For the days between 2003-04-01 and 2003-04-07, find the no of trips from the town rostov */
-- result set : date, no of trips 

select Pass_Trip.date, count(trip.town_from) as No_of_trips_from_Rostov
from Trip as trip 
join Pass_in_trip as Pass_Trip on 
Trip.trip_no=Pass_Trip.trip_no
join Company as comp on 
comp.ID_comp=trip.ID_comp
join Passenger as pass on 
Pass_Trip.ID_psg=pass.ID_psg
where trip.town_from='Rostov' 
group by Pass_Trip.date 
having Pass_Trip.date between '2003-04-01' and '2003-04-07'

/* 3 list the passengers who have visited moscow more then once */
--result name,no of vists to moscow

select pass.name,COUNT(trip.Town_from) as No_of_vists_to_moscow
from Trip as trip 
join Pass_in_trip as Pass_Trip on 
Trip.trip_no=Pass_Trip.trip_no
join Company as comp on 
comp.ID_comp=trip.ID_comp
join Passenger as pass on 
Pass_Trip.ID_psg=pass.ID_psg
where trip.Town_from='Moscow'
group by pass.name

/*4 For each company ,find the no of passengers (if any) who travelled in april 2013 by every ten-day period */
--result name,1-10,11-20,21-30
select * from [dbo].[Company]
select * from [dbo].[Passenger]
select * from [dbo].[Pass_in_trip]
select * from dbo.trip
select comp.name,count(pass.ID_psg) as Passenger_Count
from Trip as trip 
join Pass_in_trip as Pass_Trip on 
Trip.trip_no=Pass_Trip.trip_no
join Company as comp on 
comp.ID_comp=trip.ID_comp
join Passenger as pass on 
Pass_Trip.ID_psg=pass.ID_psg
where (datepart(month,Pass_Trip.date)=4)  
group by comp.name
--having (datepart(dd,Pass_Trip.date)=+10)





/* 5 Determine the total no of routes served by a flight which has maxi of trips. A-B and B-A are to be considered 
different routes */
-- result no of trips 

select count(Pass_in_Trip.trip_no)
from Trip as trip 
join Pass_in_trip as Pass_Trip on 
Trip.trip_no=Pass_Trip.trip_no
join Company as comp on 
comp.ID_comp=trip.ID_comp
join Passenger as pass on 
Pass_Trip.ID_psg=pass.ID_psg
--where Pass_in_Trip>1




/* 6 Among the clients who only use a single company, find the passengers who have flown most. */
--result -passenger name,no of trips 

/*7 Find the passengers who spent most amount of time in flight then others */
--result passenger name,total flying time in minutes

