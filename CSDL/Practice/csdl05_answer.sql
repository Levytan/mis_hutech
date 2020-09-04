--câu 1
select 
	count(*) 
from orders
where order_status = 4
--câu 2
select
	count(*)
from customers
--câu 3
select
	top(1) (select first_name + ' ' + last_name from staffs where staff_id = s.staff_id),
	count(*) as processing
from orders as o
join staffs as s on o.staff_id = s.staff_id
where o.order_status = 2
group by s.staff_id
order by processing desc
--câu 4
select
	*
from customers
where email like '%gmail%'
--câu 5
select
	top(1) last_name
from customers
group by last_name
order by count(*) desc
--câu 6
select
	[state],
	count(*)
from customers
group by [state]
--câu 7
select
	top(1) city
from customers
group by city
order by count(*) desc
--câu 8
select
	count(*)
from products
--câu 9
select
	p.product_name,
	sum(s.quantity)
from stocks as s
join products as p on s.product_id = p.product_id
group by p.product_name
--câu 10
select
	b.brand_name,
	count(*)
from products as p
join brands as b on p.brand_id = b.brand_id
group by b.brand_name
--câu 11
select
	c.category_name,
	count(*)
from products as p
join categories as c on p.category_id = c.category_id
group by c.category_name
--câu 12
select
	p.product_name, 
	sum(oi.quantity)
from order_items as oi
join orders as o on oi.order_id = o.order_id
join products as p on oi.product_id = p.product_id
join categories as c on p.category_id = c.category_id
where o.order_status = 4
	and c.category_name = 'Children Bicycles'
group by p.product_name
--câu 13
select
	p.product_name, 
	sum(oi.quantity)
from order_items as oi
join orders as o on oi.order_id = o.order_id
join products as p on oi.product_id = p.product_id
join brands as b on p.brand_id = b.brand_id
where o.order_status = 4
	and b.brand_name = 'Electra'
group by p.product_name
--câu 14
select
	sum(quantity)
from order_items as oi
join orders as o on o.order_id = oi.order_id
where o.order_status = 4
	and year(o.order_date) = 2017
--câu 15
select 
	year(order_date) as [year], 
	month(order_date) as [month], 
	count(*) as order_count
from orders
group by year(order_date), month(order_date)
order by [year], [month]
--câu 16
select
	avg(order_count * 1.0)
from (
	select  
		count(*) as order_count
	from orders
	group by year(order_date), month(order_date)
) as oc
--câu 17
select 
	product_name
from products
where product_id = (
	select 
		top(1) oi.product_id
	from order_items as oi
	join orders as o on o.order_id = oi.order_id
	where o.order_date between '2017-01-01' and '2017-06-30'
		and o.order_status = 4
	group by oi.product_id
	order by sum(oi.quantity) desc
)
--câu 18
select * from brands
where brand_id = (
	select 
		top(1) p.brand_id
	from order_items as oi
	join orders as o on o.order_id = oi.order_id
	join products as p on p.product_id = oi.product_id
	where o.order_date between '2017-07-01' and '2017-12-31'
		and o.order_status = 4
	group by p.brand_id
	order by sum(oi.quantity) desc
)
--câu 19
select * from categories
where category_id = (
	select 
		top(1) p.category_id
	from order_items as oi
	join orders as o on o.order_id = oi.order_id
	join products as p on p.product_id = oi.product_id
	where o.order_date between '2017-01-01' and '2017-12-31'
		and o.order_status = 4
	group by p.category_id
	order by sum(oi.quantity) desc
)
--câu 20
select
	sum(oi.quantity * oi.list_price * (1 - oi.discount))
from order_items as oi
join orders as o on o.order_id = oi.order_id
where o.order_date between '2018-01-01' and '2018-03-31'
	and o.order_status = 4
--câu 21
select
	top(1) oq.[quarter]
from order_items as oi
join (
	select
		order_id,
		case 
			when month(order_date) in (1, 2, 3) then 1
			when month(order_date) in (4, 5, 6) then 2
			when month(order_date) in (7, 8, 9) then 3
			else 4 end as [quarter]
	from orders
	where order_status = 4
) oq on oi.order_id = oq.order_id
group by oq.[quarter]
order by sum(oi.quantity * oi.list_price * (1 - oi.discount)) desc
--câu 22
select 
	top(1) year(o.order_date), month(o.order_date)
from order_items as oi
join orders as o on o.order_id = oi.order_id
where o.order_status = 4
group by year(o.order_date), month(o.order_date)
order by sum(oi.quantity)
--câu 23
select count(*)
from orders
where shipped_date > required_date
--câu 24
select first_name, last_name from staffs
where staff_id = (
	select 
		top(1) staff_id
	from order_items as oi
	join orders as o on o.order_id = oi.order_id
	where o.order_status = 4
		and o.order_date between '2016-10-01' and '2016-12-31'
	group by o.staff_id
	order by sum(oi.quantity)
)
--câu 25
select 
	top(1) o.order_id
from order_items as oi
join orders as o on o.order_id = oi.order_id
where o.order_status = 4
group by o.order_id
order by sum(oi.quantity * oi.list_price * (1 - oi.discount)) desc
--câu 26
select 
	top(1) (select store_name from stores where store_id = o.store_id)
from order_items as oi
join orders as o on o.order_id = oi.order_id
where o.order_status = 4
	and year(o.order_date) = 2017
group by o.store_id
order by sum(oi.quantity * oi.list_price * (1 - oi.discount)) desc
--câu 27
select sum(oi.quantity * oi.list_price * (1 - oi.discount)) / 12
from order_items as oi
join orders as o on o.order_id = oi.order_id
where o.order_status = 4
	and year(o.order_date) = 2017
--câu 28
select product_id from products
except
select product_id
from order_items as oi
join orders as o on o.order_id = oi.order_id
where o.order_status = 4
--câu 29
select 
	100.0 * count(*) / (select count(*) from orders)
from orders
where order_status = 3
--câu 30
select 
	t.staff_id, 
	100.0 * r.rejected_count / t.total_count as rejected_rate
from (
	select
		staff_id, count(*) as rejected_count
	from orders
	where order_status = 3
	group by staff_id
) as r
join (
	select
		staff_id, count(*) as total_count
	from orders
	group by staff_id
) as t on r.staff_id = t.staff_id
where t.total_count > 0
order by rejected_rate desc
--câu 30
select 
	staff_id, 
	sum(is_rejected) * 100.0 / count(*) as rejected_rate
from (
	select 
		staff_id,
		case when order_status = 3 then 1 else 0 end as is_rejected
	from orders
) t
group by staff_id
having count(*) > 0
order by rejected_rate desc