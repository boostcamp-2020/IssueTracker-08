import React, { useEffect, useState } from 'react';
import styled from 'styled-components';

import CommentStore from '../../stores/CommentStore';
import IssueDetailStore from '../../stores/IssueDetailStore';
import CommentForm from '../../components/comment/CommentForm';
import Comments from '../../components/comment/Comments';
import { GET_ISSUE } from '../../utils/api.js';
import { getOptions } from '../../utils/fetchOptions';
import { getDiffTime } from '../../utils/time';
import Container from '../../components/shared/container/Container';
import IssueStateButton from '../../components/issue/IssueStateButton';
import EditButton from '../../components/issue/IssueEdit';
import CommentNumber from '../../components/comment/CommentNumber';

const IssueHeader = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

const IssueTitle = styled.h1`
  font-size: 30px;
`;

const IssueInfo = styled.div`
  display: flex;
  align-items: center;
  padding-bottom: 8px;
  border-bottom: 1px solid #e1e4e8;
  margin-bottom: 32px;
`;

const IssueAuthor = styled.p`
  margin-right: 5px;
  font-weight: bold;
  font-size: 14px;
  color: #586069;
`;

const IssuedTime = styled.p`
  margin-right: 5px;
  font-size: 14px;
  color: #586069;
`;

const DiscussionBucket = styled.div`
  margin-bottom: 30px;
`;

const Discussion = styled.div`
  display: flex;
`;

const AuthorImage = styled.img`
  border-radius: 50%;
  width: 40px;
  height: 40px;
`;

const DiscussionContent = styled.div`
  margin-left: 20px;
  width: 832px;
`;

const CommentTimeline = styled.div`
  display: flex;
  background-color: #f1f8ff;
  align-items: center;
  border: 1px solid rgba(3, 102, 214, 0.2);
  border-radius: 5px;
  padding: 0 16px;
  border-bottom: 0px;
  border-bottom-right-radius: 0px;
  border-bottom-left-radius: 0px;
`;

const CommentAuthor = styled.p`
  margin-right: 5px;
  font-weight: bold;
  font-size: 14px;
`;

const CommentedTime = styled.p`
  font-size: 14px;
  color: #586069;
`;

const AuthorLevel = styled.span`
  padding: 0 7px;
  font-size: 12px;
  border: 1px solid rgba(3, 102, 214, 0.2);
  border-radius: 2em;
  height: 20px;
  margin-left: auto;
  margin-right: 8px;
  color: #586069;
`;

const Emoticon = styled.img`
  width: 16px;
  height: 16px;
  margin-right: 8px;
`;

const Menu = styled.img`
  width: 16px;
  height: 21px;
`;

const Comment = styled.div`
  border: 1px solid rgba(3, 102, 214, 0.2);
  border-radius: 5px;
  border-top-left-radius: 0px;
  border-top-right-radius: 0px;
  padding: 15px;
`;

export default function IssueDetailPage({ match, location }) {
  const [issueAuthorInfo, setIssueAuthorInfo] = useState('');
  const issueId = match.params.issueId;
  const userId = localStorage.getItem('userId');

  const getIssueAuthorInfo = async () => {
    const options = getOptions();
    const response = await fetch(GET_ISSUE(issueId), options);
    const responseJSON = await response.json();
    setIssueAuthorInfo(responseJSON.data[0]);
  };

  useEffect(() => {
    getIssueAuthorInfo();
  }, []);

  const IssueProvider = ({ contexts, children }) =>
    contexts.reduce(
      (prev, context) =>
        createElement(context, {
          children: prev,
        }),
      children
    );

  return (
    <IssueDetailStore issueId={issueId}>
      <CommentStore issueId={issueId} state={issueAuthorInfo.isOpen}>
        <Container>
          <IssueHeader>
            <IssueTitle>{issueAuthorInfo.title}</IssueTitle>
            <EditButton visible={issueAuthorInfo.userId === Number(userId)} />
          </IssueHeader>
          <IssueInfo>
            <IssueStateButton />
            <IssueAuthor>{issueAuthorInfo.name}</IssueAuthor>
            <IssuedTime>
              opened this issue {getDiffTime(issueAuthorInfo.closeAt)} ago ·
            </IssuedTime>
            <CommentNumber />
          </IssueInfo>
          <DiscussionBucket>
            <Discussion>
              <AuthorImage src={`${issueAuthorInfo.imageUrl}`} />
              <DiscussionContent>
                <CommentTimeline>
                  <CommentAuthor>{issueAuthorInfo.name}</CommentAuthor>
                  <CommentedTime>
                    commented {getDiffTime(issueAuthorInfo.closeAt)} ago
                  </CommentedTime>
                  <AuthorLevel>Member</AuthorLevel>
                  <Emoticon src="/images/emoticon.svg"></Emoticon>
                  <Menu src="/images/menu.svg"></Menu>
                </CommentTimeline>
                <Comment>
                  <p>{issueAuthorInfo.content}</p>
                </Comment>
              </DiscussionContent>
            </Discussion>
            <Comments />
            <CommentForm userId={userId} />
          </DiscussionBucket>
        </Container>
      </CommentStore>
    </IssueDetailStore>
  );
}
