import React, { useContext } from 'react';

import CommentContainer from '../comment/CommentContainer';
import { CommentContext } from '../../stores/CommentStore';

const OtherComments = () => {
  const { comments, loading } = useContext(CommentContext);

  let commentList = <div>Loading...</div>;
  if (!loading) {
    commentList = comments.map((comment) => (
      <CommentContainer
        key={comment.commentId}
        userId={comment.userId}
        name={comment.name}
        content={comment.content}
        imageUrl={comment.imageUrl}
        createAt={comment.createAt}
      />
    ));
  }
  return <>{commentList}</>;
};

export default OtherComments;
