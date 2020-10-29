const {
  getAllMilestones,
  getMilestone,
  createMilestone,
  updateMilestone,
  updateMilestoneState,
  deleteMilestone,
} = require('./milestone.service');
const { failResponse, successResponse } = require('../utils/returnForm');

module.exports = {
  getAllMilestones: (req, res) => {
    getAllMilestones(req, (err, results) => {
      const failMessage = '마일스톤 목록을 불러오는데 실패했습니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      return res.status(200).json(successResponse(results));
    });
  },

  getMilestone: (req, res) => {
    getMilestone(req, (err, results) => {
      const failMessage = '요청한 마일스톤 조회에 실패했습니다.';
      const failMessageById = '존재하지 않는 마일스톤에 대한 조회 요청입니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      if (results.length === 0) {
        return res.status(400).json(failResponse(failMessageById));
      }

      return res.status(200).json(successResponse(results));
    });
  },

  createMilestone: (req, res) => {
    createMilestone(req, (err, results) => {
      const failMessage = '마일스톤 등록에 실패했습니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      return res.status(200).json(successResponse(results));
    });
  },

  updateMilestone: (req, res) => {
    updateMilestone(req, (err, results) => {
      const failMessage = '마일스톤 정보 변경에 실패했습니다.';
      const failMessageById = '존재하지 않는 마일스톤에 대한 수정 요청입니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      if (results.affectedRows === 0) {
        return res.status(400).json(failResponse(failMessageById));
      }

      return res.status(200).json(successResponse(results));
    });
  },

  updateMilestoneState: (req, res) => {
    updateMilestoneState(req, (err, results) => {
      const failMessage = '마일스톤 상태 변경에 실패했습니다.';
      const failMessageById = '존재하지 않는 마일스톤에 대한 수정 요청입니다.';

      if (err) {
        return res.status(400).json(failResponse(failMessage));
      }

      if (results.affectedRows === 0) {
        return res.status(400).json(failResponse(failMessageById));
      }

      return res.status(200).json(successResponse(results));
    });
  },

  deleteMilestone: (req, res) => {
    deleteMilestone(req, (err, results) => {
      const failMessage = '마일스톤 삭제에 실패했습니다.';
      const failMessageById = '존재하지 않는 마일스톤에 대한 삭제 요청입니다.';

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
