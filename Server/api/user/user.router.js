const { getUserProfile } = require('./user.controller');
const router = require('express').Router();

router.get('/profile/:user_id', getUserProfile);

module.exports = router;
