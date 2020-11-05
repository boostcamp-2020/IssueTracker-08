const { getUserProfile, getAllUsers } = require('./user.controller');
const router = require('express').Router();

router.get('/', getAllUsers);
router.get('/profile/:user_id', getUserProfile);

module.exports = router;
