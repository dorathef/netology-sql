-- ћежду какими городами нет пр€мых рейсов?

select t1.city ->> 'ru' as departure_c, t2.city ->> 'ru' as arrival_c
from airports_data as t1
cross join airports_data as t2
where t1.city ->> 'ru' <> t2.city ->> 'ru';

select departure_c || ' Ч ' || arrival_c as route1
from (
select t1.city ->> 'ru' as departure_c, t2.city ->> 'ru' as arrival_c
from airports_data as t1
cross join airports_data as t2
where t1.city ->> 'ru' <> t2.city ->> 'ru'
) as t1;

select distinct departure_city || ' Ч ' || arrival_city as route2
from flights_v;

with t11 as (select departure_c || ' Ч ' || arrival_c as route1
from (
select t1.city ->> 'ru' as departure_c, t2.city ->> 'ru' as arrival_c
from airports_data as t1
cross join airports_data as t2
where t1.city ->> 'ru' <> t2.city ->> 'ru'
) as t1)
select route1 
from (select distinct departure_city || ' Ч ' || arrival_city as route2
from flights_v) as t10
right join t11 on route1 = route2
where route2 is null;