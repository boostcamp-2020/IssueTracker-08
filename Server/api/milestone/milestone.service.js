const { requestQuery } = require('../../config/database');
const query = require('../utils/milestone.query');

module.exports = {
  getAllMilestones: async (req, callBack) => {
    const results = await requestQuery(query.GET_MILESTONES);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },

  getMilestone: async (req, callBack) => {
    const id = req.params.milestone_id;
    const params = [id];
    const results = await requestQuery(query.GET_MILESTONE, params);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },

  createMilestone: async (req, callBack) => {
    const { title, dueDate, content } = req.body;
    const params = [title, dueDate, content];
    const results = await requestQuery(query.CREATE_MILESTONE, params);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },

  updateMilestone: async (req, callBack) => {
    const id = req.params.milestone_id;
    const { title, dueDate, content } = req.body;
    const params = [title, dueDate, content, id];
    const results = await requestQuery(query.UPDATE_MILESTONE, params);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },

  updateMilestoneState: async (req, callBack) => {
    const id = req.params.milestone_id;
    const { isOpen } = req.body;
    const params = [isOpen, id];
    const results = await requestQuery(query.UPDATE_MILESTONE_STATE, params);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },

  deleteMilestone: async (req, callBack) => {
    const id = req.params.milestone_id;
    const params = [id];
    const results = await requestQuery(query.DELETE_MILESTONE, params);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },
};
