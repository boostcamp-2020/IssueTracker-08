const mysql = require('mysql2/promise');
const dbInfo = require('./database.config');

const pool = mysql.createPool(dbInfo);

module.exports = {
  requestQuery: async (query, params) => {
    const result = {};
    const connection = await pool.getConnection(async (conn) => conn);

    try {
      result.data = await connection.execute(query, params);
      result.status = 'success';
    } catch (error) {
      result.data = error;
      result.status = 'fail';
    } finally {
      connection.release();
    }

    return result;
  },
};
