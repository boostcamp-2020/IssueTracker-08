import React, { useRef, useState, useEffect } from 'react';
import { useHistory } from 'react-router-dom';
import styled from 'styled-components';
import { GET_USER, POST_COMMENT } from '../../utils/api';
import { getOptions, postOptions } from '../../utils/fetchOptions';

const AuthorImage = styled.img`
  border-radius: 50%;
  width: 40px;
  height: 40px;
`;

const Main = styled.div`
  display: flex;
`;

const FileAttachMsg =
  'Attach files by dragging & dropping, selecting or pasting them.';

const IssueFormContainer = styled.div`
  width: 832px;
  border: 1px solid #ebecef;
  box-sizing: border-box;
  border-top-left-radius: 6px !important;
  border-top-right-radius: 6px !important;
  margin-left: 20px;
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

const CancelButton = styled.button`
  border: 0;
  outline: 0;
  background: 0;
  color: #586069;
  cursor: pointer;
`;

const SubmitDiv = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 10px;
`;

const SubmitButton = styled.button`
  width: 160px;
  box-shadow: 0px 1px 0px 0px #3dc21b;
  border-radius: 6px;
  border: 1px solid #18ab29;
  display: inline-block;
  color: white;
  font-size: 15px;
  font-weight: bold;
  padding: 10px;
  text-decoration: none;
  text-shadow: 0px -1px 0px #2f6627;
  :focus {
    outline: none;
  }
  cursor: ${(props) => (props.state ? 'pointer' : 'default')};
  background-color: ${(props) => (props.state ? '#44c767' : '#94d3a2')};
`;

const IssueCommentForm = ({ issueId, userId }) => {
  const history = useHistory();
  const commentRef = useRef(false);
  const [comment, setComment] = useState('');
  const [userImage, setUserImage] = useState('');

  const createCommentData = () => {
    if (commentRef.current.value === '') {
      return;
    }

    const comment = {
      userId: userId,
      issueId: issueId,
      content: commentRef.current.value,
    };

    const options = postOptions(comment);
    fetch(POST_COMMENT, options);
    commentRef.current.value = '';
    setComment('');
  };

  const commentHandleChange = () => {
    setComment(commentRef.current.value);
  };

  const getUserImage = async () => {
    const options = getOptions();
    const response = await fetch(GET_USER(userId), options);
    const responseJSON = await response.json();
    setUserImage(responseJSON.data[0].imageUrl);
  };

  useEffect(() => {
    getUserImage();
  }, []);

  return (
    <Main>
      <AuthorImage src={userImage}></AuthorImage>
      <IssueFormContainer>
        <WriteTab>Write</WriteTab>
        <PreviewTab>Preview</PreviewTab>
        <Hr />
        <IssueComment
          placeholder="Leave a comment"
          ref={commentRef}
          value={comment}
          onChange={commentHandleChange}
        ></IssueComment>
        <FileAttachContainer>
          <div>{FileAttachMsg}</div>
        </FileAttachContainer>
        <SubmitDiv>
          <CancelButton>Cancel</CancelButton>
          <SubmitButton state={comment} onClick={createCommentData}>
            Comment
          </SubmitButton>
        </SubmitDiv>
      </IssueFormContainer>
    </Main>
  );
};

export default IssueCommentForm;
