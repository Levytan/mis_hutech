-- câu 1
select booking_date, nights from booking
where guest_id = 1033
-- câu 2
select arrival_time, first_name, last_name
from booking b
join guest g on b.guest_id = g.id
where booking_date = '2016-11-05'
order by arrival_time
-- câu 3
select first_name, last_name, [address]
from booking b
join guest g on b.guest_id = g.id
where room_no = 101 and booking_date = '2016-12-03'
-- câu 4
select amount from rate r
join booking b on b.room_type_requested = r.room_type and b.occupants = r.occupancy
where b.booking_id in (5152, 5165, 5154, 5295)
-- câu 5
select guest_id, count(*) as booking, sum(nights) as nights
from booking
where guest_id in (1185, 1270)
group by guest_id
-- câu 6
select sum(nights * amount)
from booking b
join rate r on b.room_type_requested = r.room_type and b.occupants = r.occupancy
join guest g on b.guest_id = g.id
where g.first_name + ' ' + g.last_name = 'Ruth Cadbury'
-- câu 7
select booking_date, count(*)
from booking
where datediff(day, '2016-11-25', booking_date) between 0 and 6
group by booking_date
-- câu 8
select distinct g1.last_name
from guest as g1
join guest as g2
on g1.first_name <> g2.first_name
and g1.last_name = g2.last_name
-- câu 9
select first_name, last_name, [address], coalesce(sum(nights), 0)
from guest g
left join booking b on g.id = b.guest_id
where [address] like '%Edinburgh%'
group by first_name, last_name, [address]
-- câu 10
select id from room
except
select room_no from booking 
where booking_date <= '2016-11-25'
and dateadd(day, nights, booking_date) > '2016-11-25'
-- câu 11
select dateadd(day, nights, booking_date) as checkout, count(*) as number_of_checkout
from booking
where dateadd(day, nights, booking_date) between '2016-11-01' and '2016-11-30'
group by dateadd(day, nights, booking_date)
order by number_of_checkout desc