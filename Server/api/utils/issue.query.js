const query = {
  GET_ISSUES:
    'SELECT id, userId, milestoneId, title, content, isOpen, createAt, closeAt  FROM issue',
};

module.exports = query;
