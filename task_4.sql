/*добавьте сюда запрос для решения задания 4*/

select
	concat_ws(' ', p.first_name, p.last_name) as person,
	string_agg((b.brand_name || ' ' || m.model_name), ', ') as cars
from car_shop.orders o
inner join car_shop.persons p
  using (person_id)
inner join car_shop.brands b
  using (brand_id)
inner join car_shop.models m
  using (model_id)
group by p.first_name, p.last_name
;
