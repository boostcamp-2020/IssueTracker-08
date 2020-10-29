const express = require('express');
const router = express.Router();
const issueApiRouter = require('../api/issue/issue.router');
const milestoneApiRouter = require('../api/milestone/milestone.router');

/* API 요청 */
router.use('/api/issues', issueApiRouter);
router.use('/api/milestones', milestoneApiRouter);

module.exports = router;
