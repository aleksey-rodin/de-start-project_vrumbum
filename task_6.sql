/*добавьте сюда запрос для решения задания 6*/

select count(distinct person_id) as persons_from_usa_count
from car_shop.persons p
where p.phone like '+1%';
