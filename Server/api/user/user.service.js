const { requestQuery } = require('../../config/database');
const query = require('../utils/user.query');

module.exports = {
  getUserProfile: async (req, callBack) => {
    const id = req.params.user_id;
    const params = [id];
    const results = await requestQuery(query.GET_USER_PROFILE, params);

    if (results.status === 'success') {
      return callBack(null, results.data[0]);
    }

    return callBack(results.data);
  },
};
