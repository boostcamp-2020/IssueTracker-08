import React, { useContext } from 'react';

import { CommentContext } from '../../stores/CommentStore';
import CommentContainer from './CommentContainer';

const Comments = () => {
  const { comments, loading } = useContext(CommentContext);

  let commentList = <div></div>;

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

export default Comments;
