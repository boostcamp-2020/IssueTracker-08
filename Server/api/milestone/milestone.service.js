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
};
