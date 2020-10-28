const query = {
  GET_ISSUES:
    'SELECT id, userId, milestoneId, title, content, isOpen, createAt, closeAt  from issue',
};

module.exports = query;
