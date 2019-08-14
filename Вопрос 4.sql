-- Самолеты каких моделей совершают наибольший % перелетов?

select flight_id, f.aircraft_code, count (flight_id) over () as total_count_flights
from flights as f
join aircrafts_data as acd using (aircraft_code)
order by f.aircraft_code;

select count(flight_id) as count_flights, t1.aircraft_code, t1.total_count_flights
from (
select flight_id, f.aircraft_code, count (flight_id) over () as total_count_flights
from flights as f
join aircrafts_data as acd using (aircraft_code)
order by f.aircraft_code) as t1
group by t1.aircraft_code, t1.total_count_flights;

create view count_flights_air_code as 
select count(flight_id) as count_flights, t1.aircraft_code, t1.total_count_flights
from (
select flight_id, f.aircraft_code, count (flight_id) over () as total_count_flights
from flights as f
join aircrafts_data as acd using (aircraft_code)
order by f.aircraft_code) as t1
group by t1.aircraft_code, t1.total_count_flights;

select *, round(count_flights * 100.0/ total_count_flights, 2) as percent_of_flights
from count_flights_air_code
order by percent_of_flights desc limit 3;

select model ->> 'ru' as model, aircraft_code,
round(count_flights * 100.0/ total_count_flights, 2) as percent_of_flights 
from aircrafts_data as acd
join count_flights_air_code using (aircraft_code)
order by percent_of_flights desc limit 3;













