import React, { useEffect, useState } from 'react';

import { GET_OPEN_ISSUE } from '../../utils/api';
import { getOptions } from '../../utils/fetchOptions';

import Style from './style/ListStyle';
import IssueTemplate from './issueListTemplate';

const IssueList = () => {
  const [issues, setIssues] = useState([]);

  const loadOpenIssues = async () => {
    const response = await fetch(GET_OPEN_ISSUE, getOptions);
    const result = await response.json();
    setIssues(result.data);
    return result.data;
  };

  useEffect(() => {
    loadOpenIssues();
  }, []);

  return (
    <div className="list-wrapper">
      {issues.length > 0 ? (
        issues.map((issue) => (
          <IssueTemplate key={issue.issueId} issue={issue} />
        ))
      ) : (
        <Style.NoIssueResult>
          <span>No results matched your search.</span>
        </Style.NoIssueResult>
      )}
    </div>
  );
};

export default IssueList;
