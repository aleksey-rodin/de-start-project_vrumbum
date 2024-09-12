/*Добавьте в этот файл все запросы, для создания схемы данных автосалона и
 таблиц в ней в нужном порядке*/

create schema car_shop;

create table car_shop.countries (
	country_id smallserial primary key,  /* Количество уникальных стран не является большим числом, поэтому был выбран тип smallserial для суррогатного ключа */
	country text not null unique  /* Наименование страны является текстовым значением, поэтому text. Страны не должны дублироваться и не должны быть null, добавлены соответствующие ограничения */
);

create table car_shop.brands (
	brand_id serial primary key,  /* Для суррогатного ключа был выбран целочисленный тип с автоинкрементом, с запасом по максимальному допустимому значению */
	brand_name text not null unique,  /* Наименование марки является текстовым значением, поэтому text. Марки не должны дублироваться и не должны быть null, добавлены соответствующие ограничения */
	country_id smallint references car_shop.countries(country_id)  /* Внешний ключ, выбран тип равный типу первичного ключа в таблице countries */
);

create table car_shop.colors (
	color_id smallserial primary key,  /* Количество уникальных цветов не является большим числом, поэтому был выбран тип smallserial для суррогатного ключа */
	color_name text not null unique  /* Наименование цвета является текстовым значением, поэтому text. Цвета не должны дублироваться и не должны быть null, добавлены соответствующие ограничения */
);

create table car_shop.discounts (
	discount_id smallserial primary key,  /* Количество уникальных размеров скидок не является большим числом, поэтому был выбран тип smallserial для суррогатного ключа */
	amount smallint not null unique  /* Размер скидки не должен превышать максимальное значение типа smallint, поэтому был выбран этот тип. Размеры скидок не должны дублироваться и не должны быть null, добавлены соответствующие ограничения */
);

create table car_shop.persons (
	person_id serial primary key,  /* Для суррогатного ключа был выбран целочисленный тип с автоинкрементом, с запасом по максимальному допустимому значению */
	first_name text not null,  /* Имя является текстовым значением, поэтому text. */
	last_name text not null,  /* Фамилия страны является текстовым значением, поэтому text. */
	phone text not null unique  /* Телефон содержит символы +()-, поэтому text. Телефон должен быть уникальным значением и не может быть null, добавлены ограничения */
);

create table car_shop.models (
	model_id serial primary key,  /* Для суррогатного ключа был выбран целочисленный тип с автоинкрементом, с запасом по максимальному допустимому значению */
	model_name text not null,  /* Наименование модели авто является текстовым значением, поэтому text. Не может быть null, добавлено ограничение */
	brand_id integer not null references car_shop.brands(brand_id),  /* Внешний ключ, выбран тип равный типу первичного ключа в таблице brands. Не может быть null */
	gasoline_consumption real  /* У данного атрибута дробная часть не содержит высокой точности, поэтому выбран тип real. Для электромобилей значение отсутствует, поэтому допускается добавление null */
);

create table car_shop.orders (
	order_id serial primary key,  /* Для суррогатного ключа был выбран целочисленный тип с автоинкрементом, с запасом по максимальному допустимому значению */
	brand_id integer not null references car_shop.brands(brand_id),  /* Внешний ключ, выбран тип равный типу первичного ключа в таблице brands. Не может быть null, добавлено ограничение */
	model_id integer not null references car_shop.models(model_id),  /* Внешний ключ, выбран тип равный типу первичного ключа в таблице models. Не может быть null, добавлено ограничение */
	color_id smallint not null references car_shop.colors(color_id),  /* Внешний ключ, выбран тип равный типу первичного ключа в таблице color_id. Не может быть null, добавлено ограничение */
	person_id integer not null references car_shop.persons(person_id),  /* Внешний ключ, выбран тип равный типу первичного ключа в таблице person_id. Не может быть null, добавлено ограничение */
	price numeric not null,  /* Выбран тип numeric, т.к для этого атрибута важна точность значения после запятой. Не может быть null, добавлено ограничение */
	order_date date not null  /* Не храним время заказа, поэтому достаточно типа date. Не может быть null, добавлено ограничение */
);

create table car_shop.orders_discount (
	id serial primary key,  /* Для суррогатного ключа был выбран целочисленный тип с автоинкрементом, с запасом по максимальному допустимому значению */
	order_id integer not null not null references car_shop.orders(order_id),  /* Внешний ключ, выбран тип равный типу первичного ключа в таблице orders. Не может быть null, добавлено ограничение */
	discount_id smallint not null not null references car_shop.discounts(discount_id)  /* Внешний ключ, выбран тип равный типу первичного ключа в таблице discounts. Не может быть null, добавлено ограничение */
);
