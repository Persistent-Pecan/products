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

  getProduct: (req) => {

  },
  getProductStyles: (req) => {

  },
  getRelatedProducts: (req) => {

  },

};

// db.client.query('', [params]).then(results => res.send(results)).catch(e => res.send(e));
