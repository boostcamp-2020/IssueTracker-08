const { getAllLabels, createLabel, updateLabel } = require('./label.service');
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

  updateLabel: (req, res) => {
    updateLabel(req, (err, results) => {
      const failMessage = '라벨 정보 변경에 실패했습니다.';
      const failMessageById = '존재하지 않는 라벨에 대한 수정 요청입니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      if (results.affectedRows === 0) {
        return res.status(400).json(failResponse(failMessageById));
      }

      return res.status(200).json(successResponse(results));
    });
  },
};
