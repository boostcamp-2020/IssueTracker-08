const { githubSignIn, githubCallback } = require('./signin.service');
const router = require('express').Router();

router.get('/', githubSignIn);
router.get('/callback', githubCallback);

module.exports = router;
