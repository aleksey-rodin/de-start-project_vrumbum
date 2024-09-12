/*добавьте сюда запрос для решения задания 3*/

select
	extract(month from o.order_date) as month,
	extract(year from o.order_date) as year,
	round(avg(o.price), 2) as price_avg
from car_shop.orders o
left join car_shop.orders_discount od
  on od.order_id = o.order_id
left join car_shop.discounts d
  on d.discount_id = od.discount_id
where extract(year from o.order_date) = 2022
group by extract(month from o.order_date), extract(year from o.order_date)
order by month
;
