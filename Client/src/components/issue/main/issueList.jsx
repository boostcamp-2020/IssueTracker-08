import React, { useEffect, useState } from 'react';
import styled from 'styled-components';

import { GET_OPEN_ISSUE } from '../../../utils/api';
import { getOptions } from '../../../utils/fetchOptions';
import IssueTemplate from './issueListTemplate';

const NoIssueResult = styled.div`
  height: 300px;
  display: flex;
  font-size: 25px;
  font-weight: bold;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: 1px solid #ebecef;
  border-radius: 0 0 6px 6px;
  border-top: none;
  padding-bottom: 24px;
`;

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
        <NoIssueResult>
          <span>No results matched your search.</span>
        </NoIssueResult>
      )}
    </div>
  );
};

export default IssueList;
