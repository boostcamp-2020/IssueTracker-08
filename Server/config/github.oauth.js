const dotenv = require('dotenv');
dotenv.config();

const githubOAuth = require('github-oauth')({
  githubClient: process.env.GITHUB_CLIENT_ID,
  githubSecret: process.env.GITHUB_SECRET,
  baseURL: process.env.BASE_URL,
  loginURI: '/auth/github',
  callbackURI: '/auth/github/callback',
});

module.exports = githubOAuth;
