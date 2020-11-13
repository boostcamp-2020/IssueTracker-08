import React, { useReducer, createContext } from 'react';
import useFetch from '../hooks/useFetch';
import { GET_ALL_USERS } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { userReducer } from '../reducers/userReducer';

export const UserContext = createContext();

const UserStore = (props) => {
  const [users, dispatchUsers] = useReducer(userReducer, []);

  const setAllUsers = (initData) => {
    dispatchUsers({ type: 'SET_INIT_DATA', payload: initData });
  };

  useFetch(setAllUsers, GET_ALL_USERS, getOptions());

  return (
    <UserContext.Provider value={{ users, setAllUsers }}>
      {props.children}
    </UserContext.Provider>
  );
};

export default UserStore;
