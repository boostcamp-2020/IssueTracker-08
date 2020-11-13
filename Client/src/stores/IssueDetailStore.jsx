import React, { useReducer, useState } from 'react';
import useFetch from '../hooks/useFetch';
import { GET_ISSUE } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { issueDetailReducer } from '../reducers/issueDetailReducer';

export const IssueDetailContext = React.createContext();

const IssueDetailStore = (props) => {
  const [issueDetail, issueDetailDispatch] = useReducer(issueDetailReducer, []);
  const issueId = props.issueId;

  const setIntiData = (initData) => {
    issueDetailDispatch({
      type: 'SET_INIT_DATA',
      payload: initData,
    });
  };

  const loading = useFetch(setIntiData, GET_ISSUE(issueId), getOptions());

  return (
    <IssueDetailContext.Provider
      value={{
        issueId,
        issueDetail,
        loading,
        issueDetailDispatch,
      }}
    >
      {props.children}
    </IssueDetailContext.Provider>
  );
};

export default IssueDetailStore;
