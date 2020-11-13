import React, { useContext } from 'react';
import styled from 'styled-components';

import { CommentContext } from '../../stores/CommentStore';

const IssueCommentNum = styled.p`
  font-size: 14px;
  color: #586069;
`;

function CommentNumber() {
  const { comments } = useContext(CommentContext);
  return <IssueCommentNum>{comments.length} comments</IssueCommentNum>;
}

export default CommentNumber;
