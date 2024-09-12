/*сохраните в этом файле запросы для первоначальной загрузки данных - создание схемы raw_data и таблицы sales и наполнение их данными из csv файла*/

create schema raw_data;

create table raw_data.sales (
	id integer primary key,
	auto text not null,
	gasoline_consumption real,
	price numeric,
	"date" date,
	person_name text,
	phone text,
	discount smallint,
	brand_origin text
);

\copy raw_data.sales (id,auto,gasoline_consumption,price,date,person_name,phone,discount,brand_origin) from '/Users/rodin/Downloads/cars.csv' csv header null 'null'
