const express = require('express');
const path = require('path');
const model = require('./model.js');

const app = express();
const port = 3000;

app.use(express.json());

app.get('/products', model.getAllProducts);
app.get('/products/get');
app.get('/products/styles');
app.get('/products/related');

app.listen(port, () => {
  console.log(`listening at http://localhost:${port}`);
});
