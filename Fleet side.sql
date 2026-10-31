--F1. Rank vehicles by total fuel cost. Which two tables does this need, and is a plain JOIN enough?
--Use a left join it returns all vehicles evan if the fuel cost is null
--This needs the vehicles table and the fuel_logs table
select *
from fleet.fuel_logs;
select * from fleet.vehicles;
select v.vehicle_id,v.vehicle_plate,v.vehicle_model,sum(f.fuel_cost) as total_fuel_cost
from fleet.vehicles v
left join fleet.fuel_logs f
on v.vehicle_id = f.vehicle_id
group by v.vehicle_id ,v.vehicle_plate,v.vehicle_model
order by total_fuel_cost desc;

--F2. Which vehicles have had more than 3 maintenance events, and what's their total maintenance spend?
-- (Hint: this needs a HAVING, not a WHERE.)
select *
from fleet.maintenance_logs;
select v.vehicle_id,v.vehicle_plate,
v.vehicle_model,count(m.maintenance_log_id) as maintenance_events,
sum(m.maintenance_cost) as total_maintenance_spend
from fleet.vehicles v
join fleet.maintenance_logs m
on v.vehicle_id = m.vehicle_id
group by v.vehicle_id,v.vehicle_plate,
v.vehicle_model
having count(m.maintenance_log_id) > 3
order by total_maintenance_spend desc;

--F3. Is there a vehicle that has never had a single fuel log? 
--How would you prove a row genuinely doesn't exist on the other side of a JOIN,
-- rather than just not showing up because of a mismatched key?
select v.vehicle_id,v.vehicle_plate,
v.vehicle_model,f.fuel_log_id
from fleet.vehicles v
left join fleet.fuel_logs f
on v.vehicle_id = f.vehicle_id
where f.fuel_log_id is null;

