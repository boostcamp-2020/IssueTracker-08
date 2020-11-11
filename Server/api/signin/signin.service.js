const query = require('../utils/signin.query');
const { requestQuery } = require('../../config/database');

module.exports = {
  isExistUser: async (data) => {
    const { login: name } = data;
    const params = [name];
    const results = await requestQuery(query.GET_USER_BY_NAME, params);

    if (results.data[0].length === 1) {
      return true;
    }

    return false;
  },

  getUserAllInfo: async (data) => {
    const { login: name } = data;
    const params = [name];
    const results = await requestQuery(query.GET_USER_ALL, params);

    return results.data[0];
  },

  createUser: async (data) => {
    const { login, avatar_url } = data;
    const params = [login, `${login}@github.io`, avatar_url];
    const results = await requestQuery(query.CREATE_USER, params);
  },

  updateUserImage: async (data) => {
    const { avatar_url, login } = data;
    const params = [avatar_url, login];
    console.log(params);
    const results = await requestQuery(query.UPDATE_USER_IMAGE, params);
  },
};
