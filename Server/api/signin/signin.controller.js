const { githubSignIn } = require('./signin.service');
const { failResponse, successResponse } = require('../utils/returnForm');

module.exports = {
  githubSignIn: (req, res) => {
    githubSignIn(req.body, (err, results) => {
      const failMessage = '로그인에 실패했습니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      return res.status(200).json(successResponse(results));
    });
  },
};
