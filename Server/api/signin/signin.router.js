const router = require('express').Router();
const {
  githubSignIn,
  githubCallback,
  isLogin,
} = require('./signin.controller');
const { checkJWTAuthorization } = require('../utils/auth.token');

router.get('/', checkJWTAuthorization, isLogin);
router.get('/github', githubSignIn);
router.get('/github/callback', githubCallback);

module.exports = router;
