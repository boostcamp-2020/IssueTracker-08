const {
  getAllMilestones,
  getMilestone,
  createMilestone,
} = require('./milestone.controller');
const router = require('express').Router();

router.get('/', getAllMilestones);
router.get('/:milestone_id', getMilestone);

router.post('/', createMilestone);

module.exports = router;
