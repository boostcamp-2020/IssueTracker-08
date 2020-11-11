import React, { useReducer, createContext, useEffect, useState } from 'react';

import { GET_ALL_USERS, GET_OPEN_ISSUE, GET_CLOSED_ISSUE } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';

export const IssueContext = createContext();

export const IssuesStore = (props) => {
  const [openIssues, setOpenIssues] = useState([]);
  const [closeIssues, setCloseIssues] = useState([]);
  const [users, setUsers] = useState([]);

  const loadUsers = async () => {
    const response = await fetch(GET_ALL_USERS, getOptions());
    const result = await response.json();
    setUsers(result.data);
  };

  const loadOpenIssues = async () => {
    const response = await fetch(GET_OPEN_ISSUE, getOptions());
    const result = await response.json();
    setOpenIssues(result.data);
  };

  const loadClosedIssues = async () => {
    const response = await fetch(GET_CLOSED_ISSUE, getOptions());
    const result = await response.json();
    setCloseIssues(result.data);
  };

  useEffect(() => {
    loadUsers();
    loadOpenIssues();
    loadClosedIssues();
  }, []);

  return (
    <IssueContext.Provider
      value={{
        users,
        openIssues,
        closeIssues,
        loadUsers,
        loadOpenIssues,
        loadClosedIssues,
      }}
    >
      {props.children}
    </IssueContext.Provider>
  );
};

export default IssuesStore;
