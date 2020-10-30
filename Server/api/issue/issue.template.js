const { requestQuery } = require('../../config/database');
const query = require('../utils/issue.query');

module.exports = {
  makeIssueTemplate: async (results) => {
    const issueList = [...results.data[0]];

    for (let issue of issueList) {
      const labelList = await requestQuery(query.GET_LABELS_BY_ISSUE_ID, [
        issue.issueId,
      ]);
      const assigneeResults = await requestQuery(
        query.GET_ASSIGNEES_BY_ISSUE_ID,
        [issue.issueId]
      );
      const assigneeList = [];

      for (let assign of assigneeResults.data[0]) {
        assigneeList.push(assign.name);
      }

      issue.label = labelList.data[0];
      issue.assign = assigneeList;
    }

    return issueList;
  },
};
