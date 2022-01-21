const { Pool } = require('pg');
const config = require('../config.js');

const pool = new Pool({
  user: config.user,
  host: '54.173.94.167',
  password: config.password,
  database: 'productdb',
  port: 5432,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

pool.on('error', (err, client) => {
  console.log(err);
  process.exit(-1);
});

module.exports.pool = pool;
