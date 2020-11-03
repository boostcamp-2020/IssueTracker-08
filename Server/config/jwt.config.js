const dotenv = require('dotenv');
dotenv.config();

let jwtConfig = {};

jwtConfig.secrete = process.env.JWT_SECRETE;

module.exports = jwtConfig;
