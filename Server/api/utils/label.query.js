const query = {
  GET_LABELS: 'SELECT  id, name, color, description FROM label',
  CREATE_LABEL: 'INSERT INTO label (name, color, description) VALUES(?, ?, ?)',
  UPDATE_LABEL:
    'UPDATE label SET name = ?, color = ?, description = ? WHERE id = ?',
  DELETE_LABEL: 'DELETE FROM label WHERE id = ?',
};

module.exports = query;
