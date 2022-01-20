\timing

-- get all products, by default, page = 1 count = 5;
select json_agg(json_build_object(
  'id', p.product_id,
  'name', p.name,
  'slogan', p.slogan,
  'description', p.description,
  'category', p.category,
  'default_price', p.default_price)) from (
    select * from products where default_price > 0 limit 5
  ) p;
--Time: 17.094 ms (before)
-- Time: 3.834 ms (after)

-- get product by product_id
select json_build_object(
  'id', t.product_id,
  'name', t.name,
  'slogan', t.slogan,
  'description', t.description,
  'category', t.category,
  'default_price', t.default_price,
  'features', (select json_agg(row_to_json(features)) from (
    select feature, value from features where product_id = t.product_id
  )features)
)from (
  select p.* from products p where p.product_id = 63617 and default_price > 0
) t;

--Time: 281.384 ms (before)
--Time: 2.124 ms (after)

-- get related
select json_agg(related.related_id)
from related
join products on products.product_id = related.product_id
where products.product_id = 63609;
--Time: 793.577 ms (before)
--Time: 2.324 ms (after)

--get styles by product_id
select row_to_json(t) from (
select
product_id,
json_agg(json_build_object(
  'style_id', s.style_id,
  'name', s.name,
  'original_price', s.original_price,
  'sale_price', s.sale_price,
  'default?', s.default_style,
  'photos', (
    select coalesce(photos, '[]')
    from (
      select json_agg(json_build_object(
        'thumbnail_url', photos.thumbnail_url,
        'url', photos.url
      )) as photos from photos where photos.style_id = s.style_id
    ) as photos
  ),
  'sku', (
    select coalesce(skus, '{}')
    from (
      select json_object_agg(
        id,
        json_build_object(
          'quantity', quantity,
          'size', size
        )
      ) as skus from skus where skus.style_id = s.style_id
    ) as skus
  )
)) as results
from styles s
where product_id = 63449 and original_price > 0 group by product_id) t;

-- Time: 1936.359 ms (00:01.936) (before)
-- Time: 9.836 ms (after)
