const dotenv = require('dotenv');
dotenv.config();

const githubOAuth = require('github-oauth')({
  githubClient: process.env.GITHUB_CLIENT_ID,
  githubSecret: process.env.GITHUB_SECRET,
  baseURL: 'http://localhost:3000/',
  loginURI: '/auth/github',
  callbackURI: '/auth/github/callback',
});

module.exports = githubOAuth;
