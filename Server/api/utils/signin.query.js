const query = {
  GET_USERS: 'SELECT id, name, email, imageUrl FROM user',
  CREATE_USER: 'INSERT INTO user (name, email, imageUrl) VALUES(?, ?, ?)',
  GET_USER_BY_NAME: 'SELECT id FROM user WHERE name = ?',
  GET_USER_ALL: 'SELECT id, name, email, imageUrl FROM user WHERE name = ?',
  UPDATE_USER_IMAGE: 'UPDATE user SET  imageUrl = ? WHERE name = ?',
};

module.exports = query;
