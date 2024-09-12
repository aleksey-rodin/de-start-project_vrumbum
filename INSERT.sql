/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме автосалона*/

insert into car_shop.countries (country)
select distinct brand_origin
from raw_data.sales
where brand_origin is not null;

insert into car_shop.discounts (amount)
select distinct discount
from raw_data.sales
where discount <> 0;


insert into car_shop.colors (color_name)
select distinct ltrim(substr(s.auto, strpos(s.auto, ',') + 1)) as color_name
from raw_data.sales s
;

insert into car_shop.brands (brand_name, country_id)
select distinct rtrim(substr(s.auto, 1, strpos(s.auto, ' '))) as brand_name, c.country_id
from raw_data.sales s
left join car_shop.countries c
  on c.country = s.brand_origin
;

insert into car_shop.models (model_name, brand_id, gasoline_consumption)
select distinct ltrim(substr(s.auto, strpos(s.auto, ' '), strpos(substr(s.auto, strpos(s.auto, ' ')), ',') - 1)) as model_name,
b.brand_id, s.gasoline_consumption
from raw_data.sales s
inner join car_shop.brands b
  on b.brand_name = rtrim(substr(s.auto, 1, strpos(s.auto, ' ')))
;

insert into car_shop.persons (first_name, last_name, phone)
select distinct
    rtrim(substr(s.person_name, 1, strpos(s.person_name, ' '))) as first_name,
    ltrim(substr(s.person_name, strpos(s.person_name, ' '))) as last_name,
    s.phone
from raw_data.sales s
;

insert into car_shop.orders (brand_id, model_id, color_id, person_id, price, order_date)
select b.brand_id, m.model_id, c.color_id, p.person_id, s.price, s."date"
from raw_data.sales s
inner join car_shop.brands b
  on b.brand_name = rtrim(substr(s.auto, 1, strpos(s.auto, ' ')))
inner join car_shop.models m
  on m.model_name = ltrim(substr(s.auto, strpos(s.auto, ' '), strpos(substr(s.auto, strpos(s.auto, ' ')), ',') - 1))
  and m.brand_id = b.brand_id
inner join car_shop.colors c
  on c.color_name = ltrim(substr(s.auto, strpos(s.auto, ',') + 1))
inner join car_shop.persons p
  on p.first_name = rtrim(substr(s.person_name, 1, strpos(s.person_name, ' ')))
  and p.last_name = ltrim(substr(s.person_name, strpos(s.person_name, ' ')))
  and p.phone = s.phone
;

insert into car_shop.orders_discount (order_id, discount_id)
select o.order_id, d.discount_id
from raw_data.sales s
inner join car_shop.discounts d
  on d.amount = s.discount
inner join car_shop.persons p
  on p.first_name = rtrim(substr(s.person_name, 1, strpos(s.person_name, ' ')))
  and p.last_name = ltrim(substr(s.person_name, strpos(s.person_name, ' ')))
  and p.phone = s.phone
inner join car_shop.orders o
  on o.person_id = p.person_id
  and o.order_date = s."date"
where s.discount <> 0
;