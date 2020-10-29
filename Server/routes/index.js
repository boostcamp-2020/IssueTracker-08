const express = require('express');
const router = express.Router();
const issueApiRouter = require('../api/issue/issue.router');
const signinApiRouter = require('../api/signin/signin.router');

/* GET home page. */
router.get('/', function (req, res, next) {
  res.render('index');
});

/* API 요청 */
router.use('/api/issues', issueApiRouter);
router.use('/auth/github', signinApiRouter);

module.exports = router;
