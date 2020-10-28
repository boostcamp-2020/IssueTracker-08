const query = {
  GET_ISSUES:
    'SELECT issue.id, (SELECT user.email FROM user WHERE user.id = issue.userId) as email, (SELECT user.name FROM user WHERE user.id = issue.userId) as name, milestone.title as milestoneTitle, issue.title, issue.content, issue.isOpen, issue.createAt, issue.closeAt FROM issue join milestone on issue.milestoneID = milestone.id',
  GET_ISSUES_BY_AUTHOR:
    'SELECT issue.id, (SELECT user.email FROM user WHERE user.id = issue.userId) as email, (SELECT user.name FROM user WHERE user.id = issue.userId) as name, milestone.title as milestoneTitle, issue.title, issue.content, issue.isOpen, issue.createAt, issue.closeAt FROM issue join milestone on issue.milestoneID = milestone.id WHERE issue.userID = ?',
};

module.exports = query;
