const fetch = require('node-fetch');
const githubOAuth = require('../../config/github.oauth');
const { Headers } = require('node-fetch');
const { tokenResponse } = require('../utils/returnForm');
const {
  isExistUser,
  getUserAllInfo,
  createUser,
  updateUserImage,
} = require('./signin.service');
const { createJWT } = require('../utils/auth.token');
const { user } = require('../../config/database.config');
const { successResponse } = require('../utils/returnForm');

module.exports = {
  githubSignIn: (req, res) => {
    console.log('started oauth');

    return githubOAuth.login(req, res);
  },

  githubCallback: (req, res) => {
    console.log('received callback');

    return githubOAuth.callback(req, res);
  },

  isLogin: (req, res) => {
    return res.status(200).json(successResponse({}));
  },
};

githubOAuth.on('error', (err) => {
  console.error('there was a login error', err);
});

githubOAuth.on('token', (token, res) => {
  const myHeaders = new Headers();

  myHeaders.append('Authorization', `Bearer ${token.access_token}`);
  fetch('https://api.github.com/user', {
    headers: myHeaders,
  })
    .then((res) => {
      return res.json();
    })
    .then(async (data) => {
      if (await isExistUser(data)) {
        await updateUserImage(data);
      } else {
        await createUser(data);
      }

      const user = await getUserAllInfo(data);
      const token = createJWT(user[0]);

      res.status(200).json(tokenResponse(token));
    });
});
