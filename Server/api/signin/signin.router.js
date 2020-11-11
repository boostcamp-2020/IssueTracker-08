const router = require('express').Router();
const { isLogin, githubAuth } = require('./signin.controller');
const { checkJWTAuthorization } = require('../utils/auth.token');

router.get('/', checkJWTAuthorization, isLogin);

router.post('/github', githubAuth);

module.exports = router;
