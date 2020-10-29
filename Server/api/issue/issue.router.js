const {
  getAllOpenIssues,
  getAllCloseIssues,
  getIssue,
  createIssue,
  updateIssue,
  openIssue,
  closeIssue,
} = require('./issue.controller');
const router = require('express').Router();

router.get('/open', getAllOpenIssues); // open된 전체 이슈 조회
router.get('/closed', getAllCloseIssues); // closed된 전체 이슈 조회
router.get('/:issue_id', getIssue); // 특정 이슈 조회

router.post('/', createIssue); // 이슈 생성

router.patch('/:issue_id', updateIssue); // 이슈 수정

router.post('/open/:issue_id', openIssue); // 이슈 open
router.post('/close/:issue_id', closeIssue); // 이슈 close

module.exports = router;
