const { Pool } = require('pg');
const config = require('../config.js');

const pool = new Pool({
  user: config.user,
  host: config.host,
  password: config.password,
  database: config.database,
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
