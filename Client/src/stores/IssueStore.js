import React, { useReducer, createContext } from 'react';
import useFetch from '../hooks/useFetch';
import {
  GET_OPEN_ISSUE,
  GET_CLOSED_ISSUE,
  GET_ALL_MILESTONES,
} from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { issueReducer } from '../reducers/issueReducer';

export const IssueContext = createContext();

const IssueStore = (props) => {
  const [issues, dispatchIssues] = useReducer(issueReducer, []);
  const [openIssues, dispatchOpenIssues] = useReducer(issueReducer, []);
  const [closeIssues, dispatchCloseIssues] = useReducer(issueReducer, []);
  const [milestones, dispatchMilestones] = useReducer(issueReducer, []);

  const setIssues = (initData) => {
    dispatchIssues({ type: 'SET_INIT_DATA', payload: initData });
  };

  const setOpenIssue = (initData) => {
    dispatchOpenIssues({ type: 'SET_INIT_DATA', payload: initData });
  };

  const setClosedIssue = (initData) => {
    dispatchCloseIssues({ type: 'SET_INIT_DATA', payload: initData });
  };

  const setMilestones = (initData) => {
    dispatchMilestones({ type: 'SET_INIT_DATA', payload: initData });
  };

  useFetch(setIssues, GET_OPEN_ISSUE, getOptions());
  useFetch(setOpenIssue, GET_OPEN_ISSUE, getOptions());
  useFetch(setClosedIssue, GET_CLOSED_ISSUE, getOptions());
  useFetch(setMilestones, GET_ALL_MILESTONES, getOptions());

  return (
    <IssueContext.Provider
      value={{
        issues,
        openIssues,
        closeIssues,
        milestones,
        dispatchIssues,
        dispatchOpenIssues,
        dispatchCloseIssues,
        setIssues,
      }}
    >
      {props.children}
    </IssueContext.Provider>
  );
};

export default IssueStore;
