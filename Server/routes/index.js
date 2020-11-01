const express = require('express');
const router = express.Router();
const labelApiRouter = require('../api/label/label.router');

/* API 요청 */
router.use('/api/labels', labelApiRouter);

module.exports = router;
