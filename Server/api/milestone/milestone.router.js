const { getAllMilestones, getMilestone } = require('./milestone.controller');
const router = require('express').Router();

router.get('/', getAllMilestones);
router.get('/:milestone_id', getMilestone);

module.exports = router;
