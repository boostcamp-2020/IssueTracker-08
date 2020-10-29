const { getAllIssues } = require('./issue.controller');
const router = require('express').Router();

router.post('/', getAllIssues);

module.exports = router;
