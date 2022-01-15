const { Client } = require('pg');
const config = require('./config');

const client = new Client({
  host: 'localhost',
  user: config.user,
  password: config.password,
  database: 'productdb',
});

client.connect((err) => {
  if (err) {
    console.log('connection fail ', err);
  } else {
    console.log('connected!');
  }
});
