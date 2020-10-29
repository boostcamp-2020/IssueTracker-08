const { requestQuery } = require('../../config/database');
const { makeIssueTemplate } = require('./issue.template');
const query = require('../utils/issue.query');

module.exports = {
  getAllOpenIssues: async (req, callBack) => {
    const results = await requestQuery(query.GET_OPEN_ISSUES);

    if (results.status === 'success') {
      const issueList = await makeIssueTemplate(results);
      return callBack(null, issueList);
    }

    return callBack(results.data);
  },

  getAllCloseIssues: async (req, callBack) => {
    const results = await requestQuery(query.GET_CLOSE_ISSUES);

    if (results.status === 'success') {
      const issueList = await makeIssueTemplate(results);
      return callBack(null, issueList);
    }

    return callBack(results.data);
  },

  getIssue: async (issueId, callBack) => {
    const results = await requestQuery(query.GET_ISSUE, [issueId]);

    if (results.status === 'success') {
      if (results.data[0].length === 0) {
        return callBack(results.data);
      }

      const issueList = await makeIssueTemplate(results);
      return callBack(null, issueList);
    }

    return callBack(results.data[0]);
  },

  createIssue: async (req, callBack) => {
    const { userId, milestoneId, title, content } = req;
    const params = [userId, milestoneId, title, content];
    const results = await requestQuery(query.CREATE_ISSUE, params);

    if (results.status === 'success') {
      return callBack(null, '이슈 생성이 완료되었습니다.');
    }

    return callBack(results.data);
  },

  updateIssue: async (req, callBack) => {
    const { userId, milestoneId, title, content, id } = req;
    const params = [userId, milestoneId, title, content, id];
    const updatedItem = await requestQuery(query.UPDATE_ISSUE, params);

    if (updatedItem.data[0].affectedRows == 0) {
      return callBack('수정을 요청하신 컬럼이 존재하지 않습니다.');
    }

    const results = {
      userId,
      milestoneId,
      title,
      content,
    };

    return callBack(null, results);
  },

  openIssue: async (issueId, callBack) => {
    const results = await requestQuery(query.OPEN_ISSUE, [issueId]);

    if (results.status === 'success') {
      return callBack(null, '이슈 open이 완료되었습니다.');
    }

    return callBack(results.data);
  },

  closeIssue: async (issueId, callBack) => {
    const results = await requestQuery(query.CLOSE_ISSUE, [issueId]);

    if (results.status === 'success') {
      return callBack(null, '이슈 closed가 완료되었습니다.');
    }

    return callBack(results.data);
  },

  createAssignee: async (req, callBack) => {
    const { userId, issueId } = req;
    const params = [userId, issueId];
    const results = await requestQuery(query.CREATE_ASSIGNEE_FOR_ISSUE, params);

    if (results.status === 'success') {
      return callBack(null, '요청하신 이슈의 담당자 지정이 완료되었습니다.');
    }

    return callBack(results.data);
  },

  deleteAssignee: async (req, callBack) => {
    const { userId, issueId } = req;
    const params = [userId, issueId];
    const results = await requestQuery(query.DELETE_ASSIGNEE_FOR_ISSUE, params);

    if (results.data[0].affectedRows == 0) {
      return callBack('삭제를 요청하신 이슈가 존재하지 않습니다.');
    }

    if (results.status === 'success') {
      return callBack(null, '요청하신 이슈의 담당자 삭제가 완료되었습니다.');
    }

    return callBack(results.data);
  },

  createMilestone: async (req, callBack) => {
    const { milestoneId, issueId } = req;
    const params = [milestoneId, issueId];
    const results = await requestQuery(
      query.CREATE_MILESTONE_FOR_ISSUE,
      params
    );

    if (results.data[0].affectedRows == 0) {
      return callBack('수정을 요청하신 이슈가 존재하지 않습니다.');
    }

    if (results.status === 'success') {
      return callBack(null, '요청하신 이슈의 마일스톤 지정이 완료되었습니다.');
    }

    return callBack(results.data);
  },

  deleteMilestone: async (issueId, callBack) => {
    const results = await requestQuery(query.DELETE_MILESTONE_FOR_ISSUE, [
      issueId,
    ]);

    if (results.data[0].affectedRows == 0) {
      return callBack('수정을 요청하신 이슈가 존재하지 않습니다.');
    }

    if (results.status === 'success') {
      return callBack(null, '요청하신 이슈의 담당자 삭제가 완료되었습니다.');
    }

    return callBack(results.data);
  },

  createLabel: async (req, callBack) => {
    const { issueId, labelId } = req;
    const params = [issueId, labelId];
    const results = await requestQuery(query.CREATE_LABEL_FOR_ISSUE, params);

    if (results.status === 'success') {
      return callBack(null, '요청하신 이슈의 label 지정이 완료되었습니다.');
    }

    return callBack(results.data);
  },

  deleteLabel: async (req, callBack) => {
    const { issueId, labelId } = req;
    const params = [issueId, labelId];
    const results = await requestQuery(query.DELETE_LABEL_FOR_ISSUE, params);

    if (results.data[0].affectedRows == 0) {
      return callBack('삭제를 요청하신 이슈가 존재하지 않습니다.');
    }

    if (results.status === 'success') {
      return callBack(null, '요청하신 이슈의 label 삭제가 완료되었습니다.');
    }

    return callBack(results.data);
  },
};
