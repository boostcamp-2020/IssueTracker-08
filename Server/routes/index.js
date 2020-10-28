const express = require('express');
const router = express.Router();
const issueApiRouter = require('../api/issue/issue.router');

/* API 요청 */
router.use('/api/issue', issueApiRouter);

module.exports = router;
