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

  createLabel: async (req, callBack) => {
    const { name, color, description } = req.body;
    const params = [name, color, description];
    const results = await requestQuery(query.CREATE_LABEL, params);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },

  updateLabel: async (req, callBack) => {
    const id = req.params.label_id;
    const { name, color, description } = req.body;
    const params = [name, color, description, id];
    const results = await requestQuery(query.UPDATE_LABEL, params);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },
};
