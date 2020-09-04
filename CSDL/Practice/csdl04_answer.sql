--câu 1
select (select count(*) from Customer) as customer,
	   (select count(*) from Supplier) as supplier,
	   (select count(*) from Product) as product ,
	   (select count(*) from [Order]) as [order],
	   (select count(*) from OrderItem) as orderitem
--câu 2
select * from Customer where Country = 'USA'
--câu 3
select * from Supplier where Country = 'Japan'
--câu 4
select * from Product where UnitPrice between 10 and 20
--câu 5
select 
	count(*) 
from [Order] where year([OrderDate]) = 2013
--câu 6
select 
	avg(TotalAmount) 
from [Order] 
where year([OrderDate]) = 2013 and month([OrderDate]) = 8
--câu 7
select 
	top(10) * 
from [Order] 
order by TotalAmount desc
--câu 8
select * from (select top(1) * from Product order by UnitPrice) as t1
union all
select * from (select top(1) * from Product order by UnitPrice desc) as t2
--câu 9
select count(distinct Country) from Customer
--câu 10
select 
	p.ProductName, s.CompanyName 
from Product p
join Supplier s on p.SupplierId = s.Id
where p.IsDiscontinued = 1
--câu 11
select top(5) * from Product order by UnitPrice desc
--câu 12
select 
	top(6) p.ProductName, 
	sum(oi.Quantity) as Total 
from OrderItem oi
join Product p on oi.ProductId = p.Id
group by p.ProductName
order by Total desc
--câu 13
select 
	top(9) p.ProductName, sum(oi.Quantity * oi.UnitPrice) as Total 
from OrderItem oi
join Product p on oi.ProductId = p.Id
group by p.ProductName
order by Total desc
--câu 14
select Country, count(*) from Customer group by Country
--câu 15
select 
	month(OrderDate) as [Month], 
	count(*) as [OrderCount]
from [Order] where year([OrderDate]) = 2013
group by month(OrderDate)
--câu 16
select 
	p.ProductName, oi.UnitPrice as [OrderPrice], p.UnitPrice
from OrderItem oi
join Product p on oi.ProductId = p.Id
where oi.UnitPrice <> p.UnitPrice
--câu 17
select
	sum(TotalAmount)
from [Order]
where year([OrderDate]) = 2014 and month([OrderDate]) = 3
--câu 18
select 
	month(OrderDate) as [Month], 
	count(distinct CustomerId) as [DistinctCustomerCount]
from [Order] where year([OrderDate]) = 2013
group by month(OrderDate)
--câu 19
select * from Customer
where Id in (
	-- truy vấn id khách hàng mua đơn hàng có 'Longlife Tofu'
	select CustomerId from [Order]
	where Id in (
		-- truy vấn id đơn hàng có ProductId của 'Longlife Tofu'
		select OrderId from OrderItem
		where ProductId = (
			-- truy vấn Id của 'Longlife Tofu'
			select Id from Product
			where ProductName = 'Longlife Tofu'
		)
	) 
)
--câu 20
select * from Product where Id in (
	select Id from Product
	except
	select ProductId from OrderItem
)
--câu 21
select * from Customer where Id in (
	select Id from Customer
	except
	select CustomerId from [Order]
)
--câu 22
select 
	c.Country, sum(o.TotalAmount) as Total
from [Order] as o
join Customer as c on o.CustomerId = c.Id
group by c.Country
--câu 23
select 
	year([OrderDate]) as [Year],
	avg(TotalAmount) as [YearAvg]
from [Order]
group by year([OrderDate])
--câu 24
select
	month(o.OrderDate) as [Month],
	count(distinct oi.ProductId) as [DistinctProduct]
from OrderItem as oi
join [Order] as o on o.Id = oi.OrderId
where year(o.OrderDate) = 2012
group by month(o.OrderDate)
--câu 25
select * from [Order] where Id in (
	select
		top(1) o.Id
	from OrderItem as oi
	join [Order] as o on o.Id = oi.OrderId
	group by o.Id
	order by count(distinct oi.ProductId) desc
)
--câu 26
select * from Supplier where Id in (
	select 
		-- with ties để lấy tất cả những dòng có cùng count(*)
		top(1) with ties SupplierId
	from Product
	group by SupplierId
	order by count(*) desc
)
--câu 27
select
	month(o.OrderDate) as [Month],
	min(TotalAmount)
from OrderItem as oi
join [Order] as o on o.Id = oi.OrderId
where year(o.OrderDate) = 2014
group by month(o.OrderDate)
--câu 28
select
	oi.ProductId, 
	sum(oi.Quantity * oi.UnitPrice) as Total
from OrderItem as oi
join [Order] as o on o.Id = oi.OrderId
join Customer as c on o.CustomerId = c.Id
where c.Country = 'Germany'
group by oi.ProductId
--câu 29
select 
	c.Country,
	count(*) as OrderCount
from Customer as c
join [Order] as o on c.Id = o.CustomerId
group by c.Country
--câu 30
select 
	s.CompanyName, sum(oi.Quantity)
from OrderItem as oi
join Product as p on p.Id = oi.ProductId
join Supplier as s on s.Id = p.SupplierId
group by s.CompanyName