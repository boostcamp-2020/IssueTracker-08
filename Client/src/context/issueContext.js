import React, { useReducer, createContext, useContext } from 'react';

import { GET_ALL_USERS, GET_OPEN_ISSUE } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';

const IssueContext = createContext(null);

export const IssuesStore = async (props) => {
  const response = await fetch(GET_ALL_USERS, getOptions);
  const result = await response.json();
  const users = result.data;
  console.log(users);

  return (
    <IssueContext.Provider value={users}>
      {props.children}
    </IssueContext.Provider>
  );
};

export const useIssueState = () => {
  const state = useContext(IssueContext);

  return state;
};

export const getIssues = async () => {
  try {
    const response = await fetch(GET_OPEN_ISSUE, getOptions);
    const result = await response.json();
    return result.data;
  } catch (error) {
    console.log(error);
  }
};

export const getUsers = async () => {
  try {
    const response = await fetch(GET_ALL_USERS, getOptions);
    const result = await response.json();
    return result.data;
  } catch (error) {
    console.log(error);
  }
};
