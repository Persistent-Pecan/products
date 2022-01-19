const frisby = require('frisby');

it('GET should return a status of 200 OK for products', () => frisby
  .get('http://localhost:3000/products')
  .expect('status', 200));

const randProduct = Math.floor(Math.random() * 1000010);
it('GET should return a status of 200 OK for product by product_id', () => frisby
  .get(`http://localhost:3000/products/${randProduct}`)
  .expect('status', 200));

it('GET should return a status of 200 OK for related products', () => frisby
  .get(`http://localhost:3000/products/${randProduct}/related`)
  .expect('status', 200));

it('GET should return a status of 200 OK for product styles', () => frisby
  .get(`http://localhost:3000/products/${randProduct}/styles`)
  .expect('status', 200));
