import React from 'react';
import MainPage from '../pages/MainPage';
import LoginPage from '../pages/login/LoginPage';

const App = () => {
  const isLoggedIn = true; // TODO : setLoginState
  if (isLoggedIn) {
    return <MainPage />;
  }
  return <LoginPage />;
};

export default App;
