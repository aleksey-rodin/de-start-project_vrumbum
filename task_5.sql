/*добавьте сюда запрос для решения задания 5*/

select
	c.country as brand_origin,
	max(o.price / ((100 - coalesce(d.amount, 0))::real / 100)) as price_max,
	min(o.price / ((100 - coalesce(d.amount, 0))::real / 100)) as price_min
from car_shop.orders o
inner join car_shop.brands b
  using (brand_id)
inner join car_shop.countries c
  on c.country_id = b.country_id
left join car_shop.orders_discount od
  on od.order_id = o.order_id
left join car_shop.discounts d
  on d.discount_id = od.discount_id
group by c.country
order by price_max desc
;
