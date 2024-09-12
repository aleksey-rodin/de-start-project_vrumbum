/*добавьте сюда запрос для решения задания 2*/

select
	b.brand_name,
	extract(year from o.order_date) as year,
	round(avg(o.price), 2) as price_avg
from car_shop.models m
inner join car_shop.orders o
  on o.model_id = m.model_id
inner join car_shop.brands b
  on b.brand_id = o.brand_id
left join car_shop.orders_discount od
  on od.order_id = o.order_id
left join car_shop.discounts d
  on d.discount_id = od.discount_id
group by b.brand_name, extract(year from o.order_date)
order by b.brand_name, year
;
