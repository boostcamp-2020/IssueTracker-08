const { getAllLabels } = require('./label.controller');
const router = require('express').Router();

router.get('/', getAllLabels);

module.exports = router;
