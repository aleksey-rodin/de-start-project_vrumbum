/*добавьте сюда запрос для решения задания 5*/

select
	c.country as brand_origin,
	max(o.price / ((100 - coalesce(o.discount, 0))::real / 100)) as price_max,
	min(o.price / ((100 - coalesce(o.discount, 0))::real / 100)) as price_min
from car_shop.orders o
inner join car_shop.models m
  using (model_id)
inner join car_shop.brands b
  on b.brand_id = m.brand_id
inner join car_shop.countries c
  on c.country_id = b.country_id
group by c.country
order by price_max desc
;
