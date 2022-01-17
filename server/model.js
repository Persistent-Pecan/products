const db = require('./db');

module.exports = {
  getAllProducts: (req, res) => {
    const page = (req.query.page ? Number(req.query.page) : 1);
    const count = (req.query.count ? Number(req.query.count) : 5);
    const startIndex = (page - 1) * count;
    const query = `select json_agg(json_build_object(
      'id', p.product_id,
      'name', p.name,
      'slogan', p.slogan,
      'description', p.description,
      'category', p.category,
      'default_price', p.default_price)) from (
        select * from products where default_price > 0 and product_id > ${startIndex} limit ${count}
      ) p`;
    db.client.query(query).then(
      (results) => {
        res.status(200).send(results.rows[0].json_agg);
      },
    ).catch(
      (err) => res.send(err.stack),
    );
  },

  getProduct: (req, res) => {
    const query = `select json_build_object(
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
      select p.* from products p where p.product_id = ${req.params.product_id} and default_price > 0
    ) t`;
    db.client.query(query).then(
      (results) => {
        res.status(200).send(results.rows[0].json_build_object);
      },
    ).catch(
      (err) => res.send(err.stack),
    );
  },

  getProductStyles: (req, res) => {
    const query = `select row_to_json(t) from (
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
        )
      )) as results
      from styles s
      where product_id = ${req.params.product_id} and original_price > 0 group by product_id) t`;

    db.client.query(query).then(
      (results) => {
        res.status(200).send(results.rows[0].row_to_json);
      },
    ).catch(
      (err) => res.send(err.stack),
    );
  },
  getRelatedProducts: (req, res) => {
    const query = `
    select json_agg(related.related_id)
    from related
    join products on products.product_id = related.product_id
    where products.product_id = ${req.params.product_id}`;
    db.client.query(query).then(
      (results) => {
        res.status(200).send(results.rows[0].json_agg);
      },
    ).catch(
      (err) => res.send(err.stack),
    );
  },

};
