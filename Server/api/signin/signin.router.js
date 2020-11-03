const { githubSignIn, githubCallback } = require('./signin.controller');
const router = require('express').Router();

router.get('/github', githubSignIn);
router.get('/github/callback', githubCallback);

module.exports = router;
