const githubOAuth = require('../../config/github.oauth');
const fetch = require('node-fetch');
const { Headers } = require('node-fetch');

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
      // login, id, avatar_url
    });

  res.redirect('/');
});
