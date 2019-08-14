-- Узнать максимальное время задержки вылетов самолетов

select max (actual_departure - scheduled_departure) as max_diff
from flights_v
where status in ('Delayed', 'Departed', 'Arrived');