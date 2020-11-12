import React from 'react';
import styled from 'styled-components';
import { CheckIcon } from '@primer/octicons-react';

const IssueNumBtn = styled.button`
  cursor: pointer;
  font-size: 14px;
  background-color: Transparent;
  border: none;
  outline: none;
`;
export default function ClosedHeaderBtn({
  issueStatus,
  closeIssues,
  changeIssue,
}) {
  return (
    <>
      {issueStatus === 'closed' ? (
        <IssueNumBtn
          style={{ fontWeight: 'bold' }}
          onClick={(e) => {
            changeIssue(e, 'CHANGE_STATUS_CLOSED');
          }}
        >
          <CheckIcon size={16} className="HeaderIcon" />
          {closeIssues.length} Closed{' '}
        </IssueNumBtn>
      ) : (
        <IssueNumBtn
          style={{ color: '#586069' }}
          onClick={(e) => {
            changeIssue(e, 'CHANGE_STATUS_CLOSED');
          }}
        >
          <CheckIcon size={16} className="HeaderIcon" />
          {closeIssues.length} Closed{' '}
        </IssueNumBtn>
      )}
    </>
  );
}
