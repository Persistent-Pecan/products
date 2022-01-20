truncate styles cascade;
\copy styles from '../../data/styles.csv' delimiter ',' csv header;

truncate photos cascade;
\copy photos from '../../data/photos.csv' delimiter ',' csv header;

truncate skus cascade;
\copy skus from '../../data/skus.csv' delimiter ',' csv header;

update styles set sale_price = null where sale_price = 'null';
alter table styles alter column sale_price type integer USING sale_price::integer;
delete from styles where original_price < sale_price;