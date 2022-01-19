const { Pool } = require('pg');
const config = require('../config.js');

const pool = new Pool({
  user: config.user,
  host: 'localhost',
  database: 'productdb',
  password: config.password,
});

module.exports.pool = pool;
