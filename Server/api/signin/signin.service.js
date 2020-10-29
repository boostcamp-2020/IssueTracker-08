const fetch = require('node-fetch');
const { Headers } = require('node-fetch');

const githubOAuth = require('../../config/github.oauth');
const { requestQuery } = require('../../config/database');
const query = require('../utils/signin.query');
const { request } = require('../../app');

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

const createUser = async (data) => {
  const { login, avatar_url } = data;
  const params = [login, `${login}@github.io`, avatar_url];
  const results = await requestQuery(query.CREATE_USER, params);
  console.dir(results);
};

githubOAuth.on('error', function (err) {
  console.error('there was a login error', err);
});

githubOAuth.on('token', function (token, res) {
  console.log(token);
  const myHeaders = new Headers();

  myHeaders.append('Authorization', `Bearer ${token.access_token}`);
  fetch('https://api.github.com/user', {
    headers: myHeaders,
  })
    .then(function (res) {
      return res.json();
    })
    .then(function (data) {
      console.log(data);

      /* 
      TODO: 이메일이 중복이라면 UPDATE avatar_url 해주고
      중복이 아니라면 createUser 해주는 식으로 바꾸자.
      */
      createUser(data);
    });

  res.redirect('/');
});
