/*добавьте сюда запрос для решения задания 1*/

select round(((count(*) - count(gasoline_consumption)) / count(*)::real * 100)::numeric, 2) as nulls_percentage_gasoline_consumption
from car_shop.models;
