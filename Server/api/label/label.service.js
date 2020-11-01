const { requestQuery } = require('../../config/database');
const query = require('../utils/label.query');

module.exports = {
  getAllLabels: async (req, callBack) => {
    const results = await requestQuery(query.GET_LABELS);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },
};
