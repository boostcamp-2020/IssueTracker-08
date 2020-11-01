const {
  getAllLabels,
  createLabel,
  updateLabel,
} = require('./label.controller');
const router = require('express').Router();

router.get('/', getAllLabels);

router.post('/', createLabel);

router.put('/:label_id', updateLabel);

module.exports = router;
