const {
  getAllMilestones,
  getMilestone,
  createMilestone,
  updateMilestone,
} = require('./milestone.controller');
const router = require('express').Router();

router.get('/', getAllMilestones);
router.get('/:milestone_id', getMilestone);

router.post('/', createMilestone);

router.put('/:milestone_id', updateMilestone);

module.exports = router;
