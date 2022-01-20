truncate products cascade;
\copy products from '../../data/product.csv' delimiter ',' csv header;

truncate features cascade;
\copy features from '../../data/features.csv' delimiter ',' csv header;

truncate related cascade;
\copy related from '../../data/related.csv' delimiter ',' csv header;

