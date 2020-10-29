const { requestQuery } = require('../../config/database');
const query = require('../utils/issue.query');

module.exports = {
  getAllIssues: async (req, callBack) => {
    const results = await requestQuery(query.GET_ISSUES);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },
};
