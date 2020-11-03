const { getUser, createUser, updateUserImage } = require('./signin.service');
const fetch = require('node-fetch');
const { Headers } = require('node-fetch');
const githubOAuth = require('../../config/github.oauth');

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

  res.status(200).json({ token: 'test' });
});
