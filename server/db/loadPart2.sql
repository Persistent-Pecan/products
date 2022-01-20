truncate styles cascade;
\copy styles from '../../data/styles.csv' delimiter ',' csv header;

update styles set sale_price = null where sale_price = 'null';
alter table styles alter column sale_price type integer USING sale_price::integer;
delete from styles where original_price < sale_price;