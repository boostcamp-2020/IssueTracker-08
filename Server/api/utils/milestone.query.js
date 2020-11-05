const query = {
  GET_MILESTONES: `SELECT milestone.id, milestone.title, milestone.dueDate, milestone.content, milestone.isOpen, milestone.createAt,
  (SELECT count(issue.id) FROM issue WHERE issue.milestoneId = milestone.id and issue.isOpen = true) AS openIssue,
  (SELECT count(issue.id) FROM issue WHERE issue.milestoneId = milestone.id and issue.isOpen = false) AS closeIssue
  FROM milestone`,
  GET_MILESTONE:
    'SELECT id, title, dueDate, content, isOpen FROM milestone WHERE id = ?',
  CREATE_MILESTONE:
    'INSERT INTO milestone (title, dueDate, content) VALUES(?, ?, ?)',
  UPDATE_MILESTONE:
    'UPDATE milestone SET title = ?, dueDate = ?, content = ? WHERE id = ?',
  UPDATE_MILESTONE_STATE: 'UPDATE milestone SET isOpen = ? WHERE id = ?',
  DELETE_MILESTONE: 'DELETE FROM milestone WHERE id = ?',
};

module.exports = query;
