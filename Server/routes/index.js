const express = require('express');
const router = express.Router();

const userApiRouter = require('../api/user/user.router');
const issueApiRouter = require('../api/issue/issue.router');
const milestoneApiRouter = require('../api/milestone/milestone.router');
const signinApiRouter = require('../api/signin/signin.router');
const labelApiRouter = require('../api/label/label.router');

/* API 요청 */
// router.use('/api/users', checkJWTAuthorization, userApiRouter);
// router.use('/api/issues', checkJWTAuthorization, issueApiRouter);
// router.use('/api/milestones', checkJWTAuthorization, milestoneApiRouter);
// router.use('/api/labels', checkJWTAuthorization, labelApiRouter);
router.use('/api/users', userApiRouter);
router.use('/api/issues', issueApiRouter);
router.use('/api/milestones', milestoneApiRouter);
router.use('/api/labels', labelApiRouter);
router.use('/auth', signinApiRouter);

module.exports = router;
