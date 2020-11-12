import React, { useReducer, useEffect } from 'react';
import useFetch from '../hooks/useFetch';
import { GET_COMMENTS } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { commentReducer } from '../reducers/commentReducer';

export const CommentContext = React.createContext();

const CommentStore = (props) => {
  const [comments, commentDispatch] = useReducer(commentReducer, []);
  const issueId = props.issueId;

  const setIntiData = (initData) => {
    commentDispatch({ type: 'SET_INIT_DATA', payload: initData });
  };

  const loading = useFetch(setIntiData, GET_COMMENTS(issueId), getOptions());

  return (
    <CommentContext.Provider
      value={{ issueId, comments, loading, commentDispatch }}
    >
      {props.children}
    </CommentContext.Provider>
  );
};

export default CommentStore;
