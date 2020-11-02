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

/**
 * @swagger
 * tags:
 *   name: Issues
 *   description: 이슈에 대한 API
 */

/**
 * @swagger
 * /issues/open:
 *   get:
 *     tags: [Issues]
 *     summary: "open된 issue list"
 *     responses:
 *       200:
 *         description: "OK"
 */
router.get('/open', getAllOpenIssues);

/**
 * @swagger
 * /issues/closed:
 *   get:
 *     tags: [Issues]
 *     summary: "closed된 issue list"
 *     responses:
 *       200:
 *         description: "OK"
 */
router.get('/closed', getAllCloseIssues);

/**
 * @swagger
 * /issues/{issue_id}:
 *   get:
 *     tags: [Issues]
 *     summary: "특정 issue 조회"
 *     parameters:
 *        - name: issue_id
 *          in: path
 *          required: true
 *          schema:
 *            type: string
 *     responses:
 *       200:
 *         description: "OK"
 */
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
