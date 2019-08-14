-- Ѕыли ли брони, по которым не совершались перелеты?

select book_ref, boarding_no 
from bookings
full join tickets using (book_ref)
full join ticket_flights using (ticket_no)
full join boarding_passes using (ticket_no, flight_id)
where boarding_no is null;