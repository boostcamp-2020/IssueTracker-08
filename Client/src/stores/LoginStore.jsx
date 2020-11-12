import React, { useState, useEffect } from 'react';
import { GET_AUTH } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';

export const LoginContext = React.createContext();

const initIsLoggedIn = () => {
  if (localStorage.getItem('jwtToken')) {
    return true;
  }
  return false;
};

const LoginStore = (props) => {
  const [isLoggedIn, setIsLoggedIn] = useState(initIsLoggedIn());

  const checkValidLogin = async () => {
    const response = await fetch(GET_AUTH, getOptions());

    if (response.status === 200) {
      setIsLoggedIn(true);
    } else {
      setIsLoggedIn(false);
    }
  };

  useEffect(() => {
    checkValidLogin();
  }, [isLoggedIn]);

  return (
    <LoginContext.Provider value={{ isLoggedIn, checkValidLogin }}>
      {props.children}
    </LoginContext.Provider>
  );
};

export default LoginStore;
