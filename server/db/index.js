const { Pool } = require('pg');
const config = require('../config.js');

const pool = new Pool({
  user: config.user,
  host: '54.173.94.167',
  database: 'productdb',
  password: config.password,
});

module.exports.pool = pool;
