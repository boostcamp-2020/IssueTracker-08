const query = {
  GET_MILESTONES: 'SELECT id, title, dueDate, content, isOpen from milestone',
  GET_MILESTONE:
    'SELECT id, title, dueDate, content, isOpen from milestone where id = ?',
};

module.exports = query;
