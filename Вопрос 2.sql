-- ¬ каких аэропортах есть рейсы, 
-- которые обслуживаютс€ самолетами с максимальной дальностью перелетов?

select aircraft_code from aircrafts_data
order by "range" desc
limit 2;

select flight_id, departure_airport, f.aircraft_code
from aircrafts_data as acd
join flights as f using (aircraft_code)
where aircraft_code in (
select aircraft_code from aircrafts_data
order by "range" desc
limit 2);


create view q_2 as 
select distinct departure_airport from (select flight_id, departure_airport, f.aircraft_code
from aircrafts_data as acd
join flights as f using (aircraft_code)
where aircraft_code in (
select aircraft_code from aircrafts_data
order by "range" desc
limit 2)) as t1;


select airport_name, airport_code from airports
where airport_code in (select departure_airport from q_2);
