import React from 'react';
import styled from 'styled-components';
import { IssueOpenedIcon } from '@primer/octicons-react';

const IssueNumBtn = styled.button`
  cursor: pointer;
  font-size: 14px;
  background-color: Transparent;
  border: none;
  outline: none;
`;
export default function OpenHeaderBtn({
  issueStatus,
  openIssues,
  changeIssue,
  checkItems,
}) {
  return (
    <>
      {checkItems.isAllChecked === true ? (
        <></>
      ) : (
        <>
          {issueStatus === 'open' ? (
            <IssueNumBtn
              style={{ fontWeight: 'bold' }}
              onClick={(e) => {
                changeIssue('CHANGE_STATUS_OPEN');
              }}
            >
              <IssueOpenedIcon className="HeaderIcon" size={16} />
              {openIssues.length} Open{' '}
            </IssueNumBtn>
          ) : (
            <IssueNumBtn
              style={{ color: '#586069' }}
              onClick={(e) => {
                changeIssue('CHANGE_STATUS_OPEN');
              }}
            >
              <IssueOpenedIcon className="HeaderIcon" size={16} />
              {openIssues.length} Open{' '}
            </IssueNumBtn>
          )}
        </>
      )}
    </>
  );
}
