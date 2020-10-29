const { getAllMilestones } = require('./milestone.service');
const { failResponse, successResponse } = require('../utils/returnForm');

module.exports = {
  getAllMilestones: (req, res) => {
    getAllMilestones(req.body, (err, results) => {
      const failMessage = '마일스톤 목록을 불러오는데 실패했습니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      return res.status(200).json(successResponse(results));
    });
  },
};
