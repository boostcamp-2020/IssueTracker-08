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

  getIssuesByAuthor: async (userId, callBack) => {
    const results = await requestQuery(query.GET_ISSUES_BY_AUTHOR, [userId]);

    if (results.status === 'success') {
      if (results.data[0].length === 0) {
        return callBack(results.data);
      }

      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },
};
