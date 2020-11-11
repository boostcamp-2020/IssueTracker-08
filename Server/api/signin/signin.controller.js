const dotenv = require('dotenv');
dotenv.config();
const axios = require('axios');
const { successResponse } = require('../utils/returnForm');

const {
  isExistUser,
  getUserAllInfo,
  createUser,
  updateUserImage,
} = require('./signin.service');
const { createJWT } = require('../utils/auth.token');

const githubClientID = process.env.GITHUB_CLIENT_ID;
const githubSecret = process.env.GITHUB_SECRET;

module.exports = {
  isLogin: (req, res) => {
    return res.status(200).json(successResponse({}));
  },

  githubAuth: async (req, res) => {
    const { code } = req.body;
    try {
      const response = await axios.post(
        `https://github.com/login/oauth/access_token?client_id=${githubClientID}&client_secret=${githubSecret}&code=${code}`,
        {
          headers: {
            Accept: 'application/json',
          },
        }
      );

      const result = await response;
      const token = result.data.split('&')[0].split('access_token=')[1];

      const { data } = await axios.get('https://api.github.com/user', {
        headers: {
          Authorization: `token ${token}`,
        },
      });

      if (await isExistUser(data)) {
        await updateUserImage(data);
      } else {
        await createUser(data);
      }

      const user = await getUserAllInfo(data);
      const jwtToken = createJWT(user[0]);
      return res.status(200).json({ jwtToken: jwtToken });
    } catch (err) {
      return res.status(500);
    }
  },
};
