const { getAllMilestones } = require('./milestone.controller');
const router = require('express').Router();

router.get('/', getAllMilestones);

module.exports = router;
