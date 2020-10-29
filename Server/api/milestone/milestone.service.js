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
};
