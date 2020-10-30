const fetch = require('node-fetch');
const { Headers } = require('node-fetch');

const githubOAuth = require('../../config/github.oauth');
const query = require('../utils/signin.query');
const { requestQuery } = require('../../config/database');

module.exports = {
  githubSignIn: (req, res) => {
    console.log('started oauth');

    return githubOAuth.login(req, res);
  },

  githubCallback: (req, res) => {
    console.log('received callback');

    return githubOAuth.callback(req, res);
  },
};

const getUser = async (data) => {
  const { login } = data;
  const params = [login];
  const results = await requestQuery(query.GET_USER, params);

  return results.data[0].length;
};

const createUser = async (data) => {
  const { login, avatar_url } = data;
  const params = [login, `${login}@github.io`, avatar_url];
  const results = await requestQuery(query.CREATE_USER, params);
};

const updateUserImage = async (data) => {
  const { avatar_url } = data;
  const params = [avatar_url];
  const results = await requestQuery(query.UPDATE_USER_IMAGE, params);
};

githubOAuth.on('error', function (err) {
  console.error('there was a login error', err);
});

githubOAuth.on('token', function (token, res) {
  const myHeaders = new Headers();

  myHeaders.append('Authorization', `Bearer ${token.access_token}`);
  fetch('https://api.github.com/user', {
    headers: myHeaders,
  })
    .then(function (res) {
      return res.json();
    })
    .then(function (data) {
      getUser(data).then(function (res) {
        if (res === 1) {
          updateUserImage(data);
        } else {
          createUser(data);
        }
      });
    });

  res.redirect('/');
});
