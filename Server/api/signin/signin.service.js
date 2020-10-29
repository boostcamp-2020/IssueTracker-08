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
  console.log(token);
  res.redirect('/');
});
