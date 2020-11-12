import React from 'react';
import styled from 'styled-components';

import IssueCommentForm from '../../components/IssueCommentForm';

const Container = styled.div`
  padding: 20px 30px;
`;

const IssueHeader = styled.div`
  display: flex;
  flex-direction: row;
  align-items: center;
`;

const IssueTitle = styled.h1`
  font-size: 30px;
`;

const EditButton = styled.button`
  margin-left: auto;
  height: 30px;
  padding: 3px 12px;
  font-size: 12px;
  background-color: #fafbfc;
  &:hover {
    background-color: #e1e4e8;
  }
  border: 1px solid #e8e9ec;
  border-radius: 6px;
  cursor: pointer;
`;

const IssueInfo = styled.div`
  display: flex;
  align-items: center;
  padding-bottom: 8px;
  border-bottom: 1px solid #e1e4e8;
  margin-bottom: 32px;
`;

const StateButton = styled.button`
  color: white;
  background-color: #28a745;
  border-radius: 2em;
  border-color: transparent;
  margin-right: 8px;
  padding: 5px 12px;
  height: 35px;
  display: flex;
  align-items: center;
`;

const ExclamIcon = styled.img`
  width: 15px;
  margin-right: 4px;
`;

const State = styled.p`
  font-size: 14px;
  font-weight: bold;
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

const IssueCommentNum = styled.p`
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

export default function IssueDetailPage() {
  return (
    <>
      <Container>
        <IssueHeader>
          <IssueTitle>이슈 상세 화면</IssueTitle>
          <EditButton>Edit</EditButton>
        </IssueHeader>
        <IssueInfo>
          <StateButton>
            <ExclamIcon src="/images/exclam_circle.svg"></ExclamIcon>
            <State>Open</State>
          </StateButton>
          <IssueAuthor>yoonwoo123</IssueAuthor>
          <IssuedTime>opened this issue 22 hours ago · </IssuedTime>
          <IssueCommentNum>0 comments</IssueCommentNum>
        </IssueInfo>
        <DiscussionBucket>
          <Discussion>
            <AuthorImage src="https://avatars0.githubusercontent.com/u/45933675?s=88&u=2d19e9aa698b2fd95bb9a2ca4888b8d52bf1c304&v=4"></AuthorImage>
            <DiscussionContent>
              <CommentTimeline>
                <CommentAuthor>yoonwoo123</CommentAuthor>
                <CommentedTime>commented 22 hours ago</CommentedTime>
                <AuthorLevel>Member</AuthorLevel>
                <Emoticon src="/images/emoticon.svg"></Emoticon>
                <Menu src="/images/menu.svg"></Menu>
              </CommentTimeline>
              <Comment>
                <p>이슈 상세 화면입니다!</p>
                <p>테스트용 아무말</p>
              </Comment>
            </DiscussionContent>
          </Discussion>
        </DiscussionBucket>
        <IssueCommentForm />
      </Container>
    </>
  );
}
