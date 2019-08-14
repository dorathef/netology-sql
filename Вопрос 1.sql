-- В каких городах больше одного аэропорта?

select city, count (airport_code) as airports_count from airports
group by city
having count (airport_code) > 1;

