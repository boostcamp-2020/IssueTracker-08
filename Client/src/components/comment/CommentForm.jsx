import React, { useRef, useState, useEffect, useContext } from 'react';
import styled from 'styled-components';
import { CommentContext } from '../../stores/CommentStore';

import { GET_USER, POST_COMMENT, POST_CLOSE_ISSUE } from '../../utils/api';
import { getOptions, postOptions } from '../../utils/fetchOptions';

const Main = styled.div`
  display: flex;
  margin-top: 40px;
`;

const AuthorImage = styled.img`
  border-radius: 50%;
  width: 40px;
  height: 40px;
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
  align-items: center;
  margin: 10px;
`;

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

const SubmitButton = styled.button`
  width: 100px;
  box-shadow: 0px 1px 0px 0px #3dc21b;
  border-radius: 6px;
  border: 1px solid #18ab29;
  display: inline-block;
  color: white;
  font-size: 14px;
  font-weight: bold;
  padding: 5px 16px;
  text-decoration: none;
  text-shadow: 0px -1px 0px #2f6627;
  margin-left: 10px;
  :focus {
    outline: none;
  }
  cursor: ${(props) => (props.state ? 'pointer' : 'default')};
  background-color: ${(props) => (props.state ? '#44c767' : '#94d3a2')};
`;

const IssueCommentForm = ({ userId, issueId }) => {
  const { comments } = useContext(CommentContext);
  const commentRef = useRef(false);
  const [comment, setComment] = useState('');
  const [userImage, setUserImage] = useState('');

  const createCommentData = async () => {
    if (commentRef.current.value === '') {
      return;
    }

    console.log(userId, issueId);
    const comment = {
      userId: userId,
      issueId: issueId,
      content: commentRef.current.value,
    };

    const options = postOptions(comment);
    const response = await fetch(POST_COMMENT, options);
    await response.json();

    commentRef.current.value = '';
    setComment('');

    console.log(comments);
    // commnet 객체에 commentId, name, imageUrl, createAt 추가해야함
    // JWT 토큰 디코딩해서 유저정보 갖고오자.
    const commentAuthor = comments.filter(
      (comment) => comment.userId === userId
    );
    console.log(commentAuthor);

    // commentDispatch({ type: 'NEW_COMMENT_ADD', payload: comment });
  };

  const commentHandleChange = () => {
    setComment(commentRef.current.value);
  };

  const closeIssue = () => {
    const options = postOptions();
    fetch(POST_CLOSE_ISSUE(issueId), options);
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
      <AuthorImage src={userImage} />
      <IssueFormContainer>
        <WriteTab>Write</WriteTab>
        <PreviewTab>Preview</PreviewTab>
        <Hr />
        <IssueComment
          placeholder="Leave a comment"
          ref={commentRef}
          value={comment}
          onChange={commentHandleChange}
        />
        <FileAttachContainer>
          <div>{FileAttachMsg}</div>
        </FileAttachContainer>
        <SubmitDiv>
          <CancelButton>Cancel</CancelButton>
          <IssueButton onClick={closeIssue}>
            <CloseImage src="/images/red_close.svg" />
            <IssueState>Close issue</IssueState>
          </IssueButton>
          <SubmitButton state={comment} onClick={createCommentData}>
            Comment
          </SubmitButton>
        </SubmitDiv>
      </IssueFormContainer>
    </Main>
  );
};

export default IssueCommentForm;
