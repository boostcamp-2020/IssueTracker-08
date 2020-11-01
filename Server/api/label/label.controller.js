const { getAllLabels, createLabel } = require('./label.service');
const { failResponse, successResponse } = require('../utils/returnForm');

module.exports = {
  getAllLabels: (req, res) => {
    getAllLabels(req, (err, results) => {
      const failMessage = '라벨 목록을 불러오는데 실패했습니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      return res.status(200).json(successResponse(results));
    });
  },

  createLabel: (req, res) => {
    createLabel(req, (err, results) => {
      const failMessage = '라벨 등록에 실패했습니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      return res.status(200).json(successResponse(results));
    });
  },
};
