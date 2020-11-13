import React, { useReducer, createContext } from 'react';
import useFetch from '../hooks/useFetch';
import {
  GET_OPEN_ISSUE,
  GET_CLOSED_ISSUE,
  GET_ALL_MILESTONES,
} from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { issueReducer } from '../reducers/issueReducer';
import { checkReducer } from '../reducers/checkReducer';

export const IssueContext = createContext();

const initialState = {
  isAllChecked: false,
  checkedItems: new Set(),
};

const IssueStore = (props) => {
  const [issues, dispatchIssues] = useReducer(issueReducer, []);
  const [openIssues, dispatchOpenIssues] = useReducer(issueReducer, []);
  const [closeIssues, dispatchCloseIssues] = useReducer(issueReducer, []);
  const [milestones, dispatchMilestones] = useReducer(issueReducer, []);
  const [checkItems, dispatchCheckItems] = useReducer(
    checkReducer,
    initialState
  );

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

  const setCheckItem = (type) => {
    dispatchCheckItems(type);
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
        checkItems,
        dispatchIssues,
        dispatchOpenIssues,
        dispatchCloseIssues,
        setIssues,
        setCheckItem,
      }}
    >
      {props.children}
    </IssueContext.Provider>
  );
};

export default IssueStore;
