const query = {
  GET_MILESTONES: 'SELECT id, title, dueDate, content, isOpen FROM milestone',
  GET_MILESTONE:
    'SELECT id, title, dueDate, content, isOpen FROM milestone WHERE id = ?',
  CREATE_MILESTONE:
    'INSERT INTO milestone (title, dueDate, content) VALUES(?, ?, ?)',
};

module.exports = query;
