const query = {
  GET_USERS: 'SELECT id, name, email, imageUrl FROM user',
  CREATE_USER: 'INSERT INTO user (name, email, imageUrl) VALUES(?, ?, ?)',
  GET_USER: 'SELECT name FROM user WHERE name = ?',
  UPDATE_USER_IMAGE: 'UPDATE user SET  imageUrl = ?',
};

module.exports = query;
