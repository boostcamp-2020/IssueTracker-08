const query = {
  GET_USER_PROFILE: 'SELECT imageUrl FROM user WHERE id = ?',
  GET_ALL_USERS: 'SELECT id, email, name, imageUrl, createAt FROM user',
};

module.exports = query;
