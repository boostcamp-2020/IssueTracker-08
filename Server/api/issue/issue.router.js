const {
  getAllOpenIssues,
  getAllCloseIssues,
  getIssue,
  createIssue,
  updateIssue,
  openIssue,
  closeIssue,
  deleteIssue,
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
const { checkJWTAuthorization } = require('../utils/auth.token');

router.get('/open', getAllOpenIssues);
router.get('/closed', getAllCloseIssues);
router.get('/:issue_id', getIssue);

router.post('/', checkJWTAuthorization, createIssue);
router.post('/open/:issue_id', openIssue);
router.post('/close/:issue_id', closeIssue);
router.post('/assignee', createAssignee);
router.post('/milestone', createMilestone);
router.post('/label', createLabel);

router.put('/:issue_id', checkJWTAuthorization, updateIssue);

router.delete('/assignee', deleteAssignee);
router.delete('/milestone', deleteMilestone);
router.delete('/label', deleteLabel);

// issue의 comment 관련
router.get('/comment/:issue_id', getComments);
router.get('/comment/count/:issue_id', getCommentsCount);

router.post('/comment', checkJWTAuthorization, createComment);
router.post('/comment/update', checkJWTAuthorization, updateComment);

router.delete('/', checkJWTAuthorization, deleteIssue);
router.delete('/comment', checkJWTAuthorization, deleteComment);

module.exports = router;
