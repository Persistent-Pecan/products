const { Client } = require('pg');
const config = require('../config.js');

const client = new Client({
  user: config.user,
  host: 'localhost',
  database: 'productdb',
  password: config.password,
});

client.connect((err) => {
  if (err) {
    console.log('connection fail ', err);
  } else {
    console.log('connected!');
  }
});

module.exports.client = client;
