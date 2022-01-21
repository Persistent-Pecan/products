const express = require('express');
const path = require('path');
require('newrelic');
const model = require('./model.js');

const app = express();
const port = process.env.PORT || 3000;

app.use(express.static('loader.io'));
app.use(express.json());

app.get('/products', model.getAllProducts);
app.get('/products/:product_id', model.getProduct);
app.get('/products/:product_id/styles', model.getProductStyles);
app.get('/products/:product_id/related', model.getRelatedProducts);

app.listen(port, () => {
  console.log(`listening at http://localhost:${port}`);
});
