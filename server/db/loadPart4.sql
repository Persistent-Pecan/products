truncate skus cascade;
\copy skus from '../../data/skus.csv' delimiter ',' csv header;