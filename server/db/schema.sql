-- cd server/db
-- psql -d productdb  -a -f schema.sql
--drop database if exists productdb;
--create database productdb;

--psql -d productdb -U username -W
\connect productdb;

drop table if exists products cascade;
drop table if exists features cascade;
drop table if exists related cascade;
drop table if exists styles cascade;
drop table if exists photos cascade;

create table products (
  product_id int not null primary key,
  name varchar(50) not null,
  slogan varchar(250),
  description varchar(500),
  category varchar(100) not null,
  default_price int
);

create table features (
  feature_id int not null primary key,
  product_id int not null,
  feature varchar(50) not null,
  value varchar(50) not null,
  foreign key(product_id) references products(product_id)
);

create table related (
  id int not null primary key,
  product_id int not null,
  related_id int,
  foreign key(product_id) references products(product_id)
);

create table styles (
  style_id int not null primary key,
  product_id int not null,
  name varchar(50) not null,
  sale_price varchar(10),
  original_price int,
  default_style boolean,
  foreign key(product_id) references products(product_id)
);

create table photos (
  id int not null primary key,
  style_id int,
  url varchar,
  thumbnail_url varchar,
  foreign key(style_id) references styles(style_id)
);

truncate products cascade;
\copy products from '../../data/product.csv' delimiter ',' csv header;

truncate features cascade;
\copy features from '../../data/features.csv' delimiter ',' csv header;

truncate related cascade;
\copy related from '../../data/related.csv' delimiter ',' csv header;

truncate styles cascade;
\copy styles from '../../data/styles.csv' delimiter ',' csv header;

truncate photos cascade;
\copy photos from '../../data/photos.csv' delimiter ',' csv header;

update styles set sale_price = null where sale_price = 'null';
alter table styles alter column sale_price type integer USING sale_price::integer;
delete from styles where original_price < sale_price;

--COPY 1000011
--COPY 2219279
--COPY 4508263
--COPY 1958102
--COPY 5655463
