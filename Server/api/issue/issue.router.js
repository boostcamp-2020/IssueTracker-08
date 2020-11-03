const {
  getAllOpenIssues,
  getAllCloseIssues,
  getIssue,
  createIssue,
  updateIssue,
  openIssue,
  closeIssue,
  createAssignee,
  deleteAssignee,
  createMilestone,
  deleteMilestone,
  createLabel,
  deleteLabel,
  getComments,
  getCommentsCount,
  createComment,
  updateComment,
  deleteComment,
} = require('./issue.controller');
const router = require('express').Router();

router.get('/open', getAllOpenIssues);
router.get('/closed', getAllCloseIssues);
router.get('/:issue_id', getIssue);

router.post('/', createIssue);
router.post('/open/:issue_id', openIssue);
router.post('/close/:issue_id', closeIssue);
router.post('/assignee', createAssignee);
router.post('/milestone', createMilestone);
router.post('/label', createLabel);

router.put('/:issue_id', updateIssue);

router.delete('/assignee', deleteAssignee);
router.delete('/milestone', deleteMilestone);
router.delete('/label', deleteLabel);

// issue의 comment 관련
router.get('/comment/:issue_id', getComments);
router.get('/comment/count/:issue_id', getCommentsCount);

router.post('/comment', createComment);
router.post('/comment/update', updateComment);

router.delete('/comment', deleteComment);

module.exports = router;
