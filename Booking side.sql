select * from booking.drivers;
select * from booking.trips;

--Top 5 drivers with the most trips.We obtain the drivers name from the drivers table and trip status from the trips table
select d.driver_name,count(t.trip_id) as completed_trips
from booking.drivers d
join booking.trips t
on d.driver_id = t.driver_id 
where status = 'Completed'
group by driver_name order by completed_trips desc
limit 5;


--Customers that have never actually completed a trip, added group by to avoid duplicates
select * from booking.customers;
select c.customer_name,c.customer_area,t.status
from booking.customers c 
left join booking.trips t 
on c.customer_id = t.customer_id 
where status <> 'Completed'
group by c.customer_name,c.customer_area,t.status;

--Total revenue broken down by payment method
select * from booking.trips;
select payment_method,sum(fare_amount) as total_revenue
from booking.trips 
where status = 'Completed'
group by payment_method;

