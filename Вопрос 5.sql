-- Были ли города, в которые можно  добраться бизнес - классом дешевле, чем эконом-классом?

select apd.city ->> 'ru' as city, tf.fare_conditions, tf.amount
from airports_data as apd 
join flights as f on apd.airport_code = f.arrival_airport
join ticket_flights as tf using (flight_id);

select max(amount) as max_amount_ec, city, fare_conditions
from (
select apd.city ->> 'ru' as city, tf.fare_conditions, tf.amount
from airports_data as apd 
join flights as f on apd.airport_code = f.arrival_airport
join ticket_flights as tf using (flight_id)
) as t1
group by fare_conditions, 2
having fare_conditions = 'Economy'; -- max_economy


select min(amount) as min_amount_bu, city, fare_conditions
from (
select apd.city ->> 'ru' as city, tf.fare_conditions, tf.amount
from airports_data as apd 
join flights as f on apd.airport_code = f.arrival_airport
join ticket_flights as tf using (flight_id)
) as t1
group by fare_conditions, 2
having fare_conditions = 'Business'; -- min_business

select t10.city, t10.min_amount_bu, t11.max_amount_ec
from (
  select min(amount) as min_amount_bu, city, fare_conditions
  from (
    select apd.city ->> 'ru' as city, tf.fare_conditions, tf.amount
    from airports_data as apd 
    join flights as f on apd.airport_code = f.arrival_airport
    join ticket_flights as tf using (flight_id)
    ) as t1
  group by fare_conditions, 2
  having fare_conditions = 'Business'
) as t10
join (
  select max(amount) as max_amount_ec, city, fare_conditions
  from (
    select apd.city ->> 'ru' as city, tf.fare_conditions, tf.amount
    from airports_data as apd 
    join flights as f on apd.airport_code = f.arrival_airport
    join ticket_flights as tf using (flight_id)
    ) as t1
  group by fare_conditions, 2
  having fare_conditions = 'Economy'
)as t11 on t10.city = t11.city
where t10.min_amount_bu < t11.max_amount_ec;
