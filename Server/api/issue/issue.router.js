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
} = require('./issue.controller');
const router = require('express').Router();

router.get('/open', getAllOpenIssues); // open된 전체 이슈 조회
router.get('/closed', getAllCloseIssues); // closed된 전체 이슈 조회
router.get('/:issue_id', getIssue); // 특정 이슈 조회

router.post('/', createIssue); // 이슈 생성
router.post('/open/:issue_id', openIssue); // 이슈 open
router.post('/close/:issue_id', closeIssue); // 이슈 close
router.post('/assignee', createAssignee); // 이슈 담당자 생성

router.put('/:issue_id', updateIssue); // 이슈 수정

router.delete('/assignee', deleteAssignee); // 이슈 담당자 삭제

// 이슈 라벨 생성
// 이슈 라벨 삭제

// 이슈 마일스톤 생성
// 이슈 마일스톤 삭제

// 이슈에 댓글 달면, 그에 맞는 코멘트 생성
// 이슈의 코멘트 개수 반환

module.exports = router;
