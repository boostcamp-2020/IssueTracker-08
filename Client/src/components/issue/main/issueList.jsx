import React, { useContext } from 'react';
import styled from 'styled-components';

import IssuesStore from '../../../stores/IssueStore';
import IssueTemplate from './issueListTemplate';
import { IssueContext } from '../../../stores/IssueStore';

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
  const { issues } = useContext(IssueContext);

  return (
    <IssuesStore>
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
    </IssuesStore>
  );
};

export default IssueList;
