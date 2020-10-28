const { getAllIssues, getIssuesByAuthor } = require('./issue.controller');
const router = require('express').Router();

router.post('/', getAllIssues);
router.get('/:userId', getIssuesByAuthor);

module.exports = router;
