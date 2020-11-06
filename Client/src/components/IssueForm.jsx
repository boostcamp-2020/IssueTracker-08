import React, { useRef } from 'react';
import { Link, useHistory } from 'react-router-dom';
import styled from 'styled-components';

import { POST_ISSUE } from '../utils/api';
import { postOptions } from '../utils/fetchOptions';

const FileAttachMsg =
  'Attach files by dragging & dropping, selecting or pasting them.';

const IssueFormContainer = styled.div`
  width: 70%;
  margin: auto;
  border: 1px solid #ebecef;
  box-sizing: border-box;
  border-top-left-radius: 6px !important;
  border-top-right-radius: 6px !important;
`;

const IssueTitleInput = styled.input`
  width: 95%;
  margin: 10px;
  padding: 5px 12px;
  font-size: 14px;
  line-height: 20px;
  background-position: right 8px center;
  background-color: #fafbfc;
  border: 1px solid #ebecef;
  border-radius: 6px;
  outline: none;
  &:hover {
    background-color: white;
  }
`;

const WriteTab = styled.div`
  display: inline-block;
  margin: 0 8px;
  cursor: pointer;
  padding: 8px 16px;
  font-size: 14px;
  line-height: 23px;
  text-decoration: none;
  border: 1px solid #ebecef;
  border-radius: 6px 6px 0 0;
  padding-right: 16px !important;
  padding-left: 16px !important;
  border-bottom: 0;
`;

const PreviewTab = styled.div`
  display: inline-block;
  padding: 8px;
  cursor: pointer;
  font-size: 14px;
  line-height: 23px;
  color: rgba(0, 0, 0, 0.87);
  background-color: initial;
  border-bottom: 0;
  text-decoration: none;
`;

const Hr = styled.div`
  border-bottom: 1px solid #ebecef;
`;

const IssueComment = styled.textarea`
  width: 95%;
  min-height: 150px;
  max-height: 500px;
  margin: 10px;
  margin-bottom: 0;
  padding: 8px;
  padding-bottom: 0;
  font-size: 14px;
  font-family: Lato, 'Helvetica Neue', Arial, Helvetica, sans-serif;
  line-height: 20px;
  background-position: right 8px center;
  background-color: rgb(250, 251, 252);
  border: 1px solid #ebecef;
  border-radius: 6px;
  border-bottom: 1px dashed #ebecef;
  outline: none;
  resize: vertical;
  border-bottom-right-radius: 0;
  border-bottom-left-radius: 0;
`;

const FileAttachContainer = styled.div`
  width: 95%;
  font-size: 14px;
  vertical-align: middle;
  font-family: Lato, 'Helvetica Neue', Arial, Helvetica, sans-serif;
  border: 1px solid #e1e4e8;
  border-top: none;
  border-radius: 0 0 6px 6px;
  cursor: pointer;
  background-color: rgb(250, 251, 252);
  margin: 10px;
  margin-top: 0;
  padding: 8px;
  padding-top: 0;
  color: #586069;
`;

const SubmitDiv = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 10px;
`;

const CancelButton = styled.button`
  border: 0;
  outline: 0;
  background: 0;
  color: #586069;
  cursor: pointer;
  font-size: 15px;
  font-weight: bold;
`;

const SubmitButton = styled.button`
  width: 160px;
  box-shadow: 0px 1px 0px 0px #3dc21b;
  background: linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%);
  background-color: #44c767;
  border-radius: 6px;
  border: 1px solid #18ab29;
  display: inline-block;
  cursor: pointer;
  color: white;
  font-size: 15px;
  font-weight: bold;
  padding: 10px;
  text-decoration: none;
  text-shadow: 0px -1px 0px #2f6627;
`;

const IssueForm = () => {
  const history = useHistory();
  const titleRef = useRef(false);
  const commentRef = useRef(false);

  const createIssueData = (e) => {
    const issue = {
      userId: 1,
      milestoneId: null,
      title: titleRef.current.value,
      content: commentRef.current.value,
    };
    const options = postOptions(issue);
    fetch(POST_ISSUE, options);
    history.push('/');
  };

  return (
    <IssueFormContainer>
      <IssueTitleInput placeholder="Title" ref={titleRef} />
      <WriteTab>Write</WriteTab>
      <PreviewTab>Preview</PreviewTab>
      <Hr />
      <IssueComment
        placeholder="Leave a comment"
        ref={commentRef}
      ></IssueComment>
      <FileAttachContainer>
        <div>{FileAttachMsg}</div>
      </FileAttachContainer>
      <SubmitDiv>
        <Link to="/">
          <CancelButton>Cancel</CancelButton>
        </Link>
        <SubmitButton onClick={createIssueData}>Submit new issue</SubmitButton>
      </SubmitDiv>
    </IssueFormContainer>
  );
};

export default IssueForm;
