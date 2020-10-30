const express = require('express');
const router = express.Router();
const userApiRouter = require('../api/user/user.router');
const issueApiRouter = require('../api/issue/issue.router');

/* API 요청 */
router.use('/api/users', userApiRouter);
router.use('/api/issues', issueApiRouter);

module.exports = router;
