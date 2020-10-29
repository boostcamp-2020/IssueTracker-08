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

// 이슈에 댓글 달면, 그에 맞는 코멘트 생성
// 이슈의 코멘트 개수 반환

module.exports = router;
