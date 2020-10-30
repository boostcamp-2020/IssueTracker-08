const query = {
  GET_OPEN_ISSUES:
    'SELECT issue.id as issueId, (SELECT user.email FROM user WHERE user.id = issue.userId) as email, (SELECT user.name FROM user WHERE user.id = issue.userId) as name, (SELECT milestone.title FROM milestone WHERE issue.milestoneID = milestone.id) as milestone, issue.title, issue.content, issue.isOpen, issue.createAt, issue.closeAt FROM issue WHERE issue.isOpen = 1',
  GET_CLOSE_ISSUES:
    'SELECT issue.id as issueId, (SELECT user.email FROM user WHERE user.id = issue.userId) as email, (SELECT user.name FROM user WHERE user.id = issue.userId) as name, (SELECT milestone.title FROM milestone WHERE issue.milestoneID = milestone.id) as milestone, issue.title, issue.content, issue.isOpen, issue.createAt, issue.closeAt FROM issue WHERE issue.isOpen = 0',
  GET_ISSUE:
    'SELECT issue.id as issueId, (SELECT user.email FROM user WHERE user.id = issue.userId) as email, (SELECT user.name FROM user WHERE user.id = issue.userId) as name, (SELECT milestone.title FROM milestone WHERE issue.milestoneID = milestone.id) as milestone, issue.title, issue.content, issue.isOpen, issue.createAt, issue.closeAt FROM issue WHERE issue.id = ?',
  GET_LABELS_BY_ISSUE_ID:
    'SELECT (SELECT label.name FROM label WHERE label.id = issue_label.labelId) as labelName, (SELECT label.color FROM label WHERE label.id = issue_label.labelId) as labelColor, (SELECT label.description FROM label WHERE label.id = issue_label.labelId) as labelDescription FROM issue JOIN issue_label ON issue.id = issue_label.issueId WHERE issue_label.issueId = ?',
  GET_ASSIGNEES_BY_ISSUE_ID:
    'SELECT (SELECT user.name FROM user WHERE user.id = issue_assignee.userId) as name FROM issue JOIN issue_assignee ON issue.id = issue_assignee.issueId WHERE issue_assignee.issueId = ?',
  CREATE_ISSUE:
    'INSERT INTO issue (userId, milestoneId, title, content) VALUES(?, ?, ?, ?)',
  UPDATE_ISSUE:
    'UPDATE issue SET userId = ?, milestoneId = ?, title = ?, content = ? WHERE id = ?',
  OPEN_ISSUE: 'UPDATE issue SET isOpen = 1 WHERE id = ?',
  CLOSE_ISSUE: 'UPDATE issue SET isOpen = 0 WHERE id = ?',
  CREATE_ASSIGNEE_FOR_ISSUE:
    'INSERT INTO issue_assignee (userId, issueId) VALUES(?, ?)',
  DELETE_ASSIGNEE_FOR_ISSUE:
    'DELETE FROM issue_assignee WHERE userId = ? and issueId = ?',
  CREATE_MILESTONE_FOR_ISSUE: 'UPDATE issue SET milestoneId = ? WHERE id = ?',
  DELETE_MILESTONE_FOR_ISSUE:
    'UPDATE issue SET milestoneId = NULL WHERE id = ?',
  CREATE_LABEL_FOR_ISSUE:
    'INSERT INTO issue_label (issueId, labelId) VALUES(?, ?)',
  DELETE_LABEL_FOR_ISSUE:
    'DELETE FROM issue_label WHERE issueId = ? and labelId = ?',
  CREATE_COMMENT:
    'INSERT INTO comment (userId, issueId, content) VALUES(?, ?, ?)',
  UPDATE_COMMENT:
    'UPDATE comment SET userId = ?, issueId = ?, content = ? WHERE id = ?',
  DELETE_COMMENT: 'DELETE FROM comment WHERE id = ?',
  GET_COMMENTS:
    'SELECT comment.id as commentId, (SELECT user.name FROM user WHERE user.id = comment.userId) as name, comment.content, comment.createAt FROM comment WHERE comment.issueId = ?',
  GET_COMMENTS_COUNT:
    'SELECT count(*) as commentCount FROM comment where issueId = ?',
};

module.exports = query;
