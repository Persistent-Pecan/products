\timing

-- get all products, by default, page = 1 count = 5;
select * from products where default_price > 0 limit 5;
--Time: 1.856 ms

-- get product by product_id
select products.*, feature, value from features join products on products.product_id = features.product_id where products.product_id = 63609 and default_price > 0;
--Time: 452.468 ms

-- get related
select related.id, related.product_id as current_product_id, related.related_id as related_product_id from related join products on products.product_id = related.product_id where products.product_id = 63609;
--Time: 630.782 ms

--get styles by product_id
select styles.*, photos.id as photo_id, photos.url, photos.thumbnail_url from styles join photos on styles.style_id = photos.style_id where product_id = 63609 and original_price > 0 and sale_price > 0 and original_price > sale_price;
-- Time: 4473.987 ms (00:04.474)