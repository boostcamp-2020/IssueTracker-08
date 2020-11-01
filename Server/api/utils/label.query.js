const query = {
  GET_LABELS: 'SELECT  id, name, color, description FROM label',
  CREATE_LABEL: 'INSERT INTO label (name, color, description) VALUES(?, ?, ?)',
};

module.exports = query;
