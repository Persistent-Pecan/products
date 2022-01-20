\connect productdb;

drop table if exists products cascade;
drop table if exists features cascade;
drop table if exists related cascade;
drop table if exists styles cascade;
drop table if exists photos cascade;
drop table if exists skus cascade;

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

create table skus (
  id int not null primary key,
  style_id int,
  size varchar(10),
  quantity int check(quantity >= 0),
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

truncate skus cascade;
\copy skus from '../../data/skus.csv' delimiter ',' csv header;

update styles set sale_price = null where sale_price = 'null';
alter table styles alter column sale_price type integer USING sale_price::integer;
delete from styles where original_price < sale_price;

-- create index for styles
create index original_price_idx on styles(original_price);
create index product_id_idx on styles (product_id);
create index style_id_idx on photos (style_id);

-- create index for products
create index default_price_idx on products(default_price);

-- create index for single product
create index product_feature_idx on features(product_id);

-- create index for related product
create index product_related_idx on related(product_id);

-- create index for skus
create index sku_style_idx on skus(style_id);

