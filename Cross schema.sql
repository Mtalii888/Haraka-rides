--For completed trips, show the vehicle's plate, make, and model alongside the trip
select * from booking.trips;
select * from fleet.vehicles;
--X1. For completed trips, show the vehicle's plate, make, and model alongside the trip.
-- This is the simplest possible cross-schema JOIN - get comfortable with it before the harder ones below.
select v.vehicle_plate,
v.vehicle_make,
v.vehicle_model,
t.trip_id,
t.status
from fleet.vehicles v 
join booking.trips t
on v.vehicle_id = t.vehicle_id
where t.status = 'Completed';

--X2. Total revenue generated per vehicle (completed trips only). 
--Some vehicles may have generated zero revenue - make sure your JOIN choice doesn't accidentally drop them from the result.
select v.vehicle_plate,
v.vehicle_make,
v.vehicle_model,
t.status,
sum(fare_amount) as total_revenue
from fleet.vehicles v 
left join booking.trips t
on v.vehicle_id = t.vehicle_id
--where t.status = 'Completed'
group by  v.vehicle_plate,
v.vehicle_make,
v.vehicle_model,
t.status
;

--X3. Are there any vehicles marked 'Under Repair' in the fleet system that still show up carrying trips in the booking system? 
--What would that finding mean for the business, if it existed?


select *
from fleet.maintenance_logs;
select v.vehicle_plate,
v.vehicle_make,
v.vehicle_model,
m.maintenance_log_id,
m.service_type,
t.status
from fleet.vehicles v 
join fleet.maintenance_logs m
on v.vehicle_id = m.vehicle_id
join booking.trips t
on v.vehicle_id = t.vehicle_id
where t.status <> 'No Show'
;

