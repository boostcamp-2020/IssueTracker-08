import React, { useContext } from 'react';
import styled from 'styled-components';

import { postOptions } from '../../utils/fetchOptions';
import { POST_CLOSE_ISSUE, POST_OPEN_ISSUE } from '../../utils/api';
import { CommentContext } from '../../stores/CommentStore';
import { IssueDetailContext } from '../../stores/IssueDetailStore';

const CloseImage = styled.img`
  width: 16px;
`;

const IssueState = styled.p`
  font-size: 14px;
  font-weight: bold;
  margin-left: 8px;
`;

const IssueButton = styled.button`
  width: 136px;
  box-shadow: 0px 1px 0px 0px #fafbfc;
  border-radius: 6px;
  border: 1px solid #1b1f2326;
  display: flex;
  align-items: center;
  height: 28px;
  color: #24292e;
  padding: 5px 16px;
  text-decoration: none;
  text-shadow: 0px -1px 0px #fafbfc;
  cursor: pointer;
  margin-left: auto;
  background-color: #fafbfc;
  :focus {
    outline: none;
  }
`;

const IssueCloseButton = () => {
  const { issueId } = useContext(CommentContext);
  const { issueDetail, issueDetailDispatch } = useContext(IssueDetailContext);

  const closeIssue = async () => {
    const options = postOptions();
    await fetch(POST_CLOSE_ISSUE(issueId), options);
    issueDetailDispatch({
      type: 'CLOSE_ISSUE',
      payload: issueDetail,
    });
  };

  const openIssue = async () => {
    const options = postOptions();
    await fetch(POST_OPEN_ISSUE(issueId), options);
    issueDetailDispatch({
      type: 'OPEN_ISSUE',
      payload: issueDetail,
    });
  };

  if (issueDetail.isOpen === 1) {
    return (
      <IssueButton onClick={closeIssue}>
        <CloseImage src="/images/red_close.svg" />
        <IssueState>Close issue</IssueState>
      </IssueButton>
    );
  } else if (issueDetail.isOpen === 0) {
    return (
      <IssueButton onClick={openIssue}>
        <IssueState>Reopen issue</IssueState>
      </IssueButton>
    );
  }
  return <div>Loading..</div>;
};

export default IssueCloseButton;
