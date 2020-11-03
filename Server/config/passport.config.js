const passport = require('passport');
const jwtObject = require('../config/jwt.config');
const { ExtractJwt, Strategy: JWTStrategy } = require('passport-jwt');
const { isExistUser } = require('../api/signin/signin.service');

const JWTConfig = {
  jwtFromRequest: ExtractJwt.fromHeader('authorization'),
  secretOrKey: jwtObject.secrete,
};

const JWTVerify = async (jwtPayload, done) => {
  try {
    const name = jwtPayload.name;

    if (await isExistUser({ login: name })) {
      done(null, name);
      return;
    }

    done(null, false, { reason: '올바르지 않은 인증정보 입니다.' });
  } catch (error) {
    console.error(error);
    done(error);
  }
};

module.exports = () => {
  passport.use('jwt', new JWTStrategy(JWTConfig, JWTVerify));
};
