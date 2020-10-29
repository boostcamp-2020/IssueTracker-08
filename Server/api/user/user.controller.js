const { getUserProfile } = require('./user.service');
const { failResponse, successResponse } = require('../utils/returnForm');

module.exports = {
  getUserProfile: (req, res) => {
    getUserProfile(req, (err, results) => {
      const failMessage = '사용자 이미지를 불러오는데 실패했습니다.';
      const failMessageById = '존재하지 않는 사용자입니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      if (results.length === 0) {
        return res.status(400).json(failResponse(failMessageById));
      }

      return res.status(200).json(successResponse(results));
    });
  },
};
