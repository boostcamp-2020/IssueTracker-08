const { getAllLabels, createLabel } = require('./label.controller');
const router = require('express').Router();

router.get('/', getAllLabels);

router.post('/', createLabel);

module.exports = router;
