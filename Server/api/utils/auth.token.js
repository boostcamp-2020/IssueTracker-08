const jwt = require('jsonwebtoken');
const jwtConfig = require('../../config/jwt.config');

const createJWT = (user) => {
  return jwt.sign(
    {
      id: user.id,
      email: user.email,
      name: user.name,
      imageUrl: user.imageUrl,
    },
    jwtConfig.secrete
  );
};

const decodeJWT = async (req) => {
  return jwt.verify(req.headers.authorization, jwtConfig.secrete);
};

module.exports = {
  createJWT,
  decodeJWT,
};
