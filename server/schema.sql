-- psql postgres
-- psql -d productdb -f schema.sql
drop database if exists productdb;
create database productdb;

\connect productdb;

create table products (
  product_id int not null primary key,
  name varchar(50) not null,
  slogan varchar(250),
  description varchar(500),
  category varchar(100) not null,
  default_price real check(default_price > 0)
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
  foreign key(product_id) references products(product_id),
  foreign key(related_id) references products(product_id),
);

create table styles (
  style_id int not null primary key,
  product_id int not null,
  name varchar(50) not null,
  original_price real check(original_price > 0),
  sale_price real check(sale_price < original_price),
  default boolean not null,
  foreign key(product_id) references products(product_id)
);

create table photos (
  id int not null primary key,
  style_id int not null,
  thumbnail_url varchar,
  url varchar,
  foreign key(style_id) references styles(style_id)
);