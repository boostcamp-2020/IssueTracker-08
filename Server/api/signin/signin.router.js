const router = require('express').Router();

const { isLogin, githubAuth, appleAuth } = require('./signin.controller');
const { checkJWTAuthorization } = require('../utils/auth.token');

router.get('/', checkJWTAuthorization, isLogin);

router.post('/github', githubAuth);
router.post('/apple', appleAuth);

module.exports = router;
