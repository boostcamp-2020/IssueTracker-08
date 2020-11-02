const express = require('express');
const router = express.Router();
const userApiRouter = require('../api/user/user.router');
const issueApiRouter = require('../api/issue/issue.router');
const milestoneApiRouter = require('../api/milestone/milestone.router');
const signinApiRouter = require('../api/signin/signin.router');

/* API 요청 */
router.use('/api/users', userApiRouter);
router.use('/api/issues', issueApiRouter);
router.use('/api/milestones', milestoneApiRouter);
router.use('/auth/github', signinApiRouter);

module.exports = router;
