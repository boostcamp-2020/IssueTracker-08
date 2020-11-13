import React, { useReducer } from 'react';
import useFetch from '../hooks/useFetch';
import { GET_COMMENTS } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { commentReducer } from '../reducers/commentReducer';

export const CommentContext = React.createContext();

const CommentStore = (props) => {
  const [comments, commentDispatch] = useReducer(commentReducer, []);
  const issueId = props.issueId;
  const state = props.state;

  const setIntiData = (initData) => {
    commentDispatch({ type: 'SET_INIT_DATA', payload: initData });
  };

  const loading = useFetch(setIntiData, GET_COMMENTS(issueId), getOptions());

  return (
    <CommentContext.Provider
      value={{ issueId, state, comments, loading, commentDispatch }}
    >
      {props.children}
    </CommentContext.Provider>
  );
};

export default CommentStore;
