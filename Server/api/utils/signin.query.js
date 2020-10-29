const query = {
  GET_USERS: 'SELECT id, name, email, imageUrl FROM user',
  CREATE_USER: 'INSERT INTO user (name, email, imageUrl) VALUES(?, ?, ?)',
};

module.exports = query;
