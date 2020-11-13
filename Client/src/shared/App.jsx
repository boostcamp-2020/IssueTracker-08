import React from 'react';
import { createGlobalStyle } from 'styled-components';

import LoginStore from '../stores/LoginStore';
import Header from '../components/shared/container/Header';
import MainRouter from '../router/MainRouter';
import LoginRouter from '../router/LoginRouter';

const GlobalStyle = createGlobalStyle`
  body {
    margin: 0px;
    padding: 0px;
    *:focus { outline:none; }
  }
`;

const App = () => {
  return (
    <LoginStore>
      <Header></Header>
      <MainRouter />
      <LoginRouter />
      <GlobalStyle />
    </LoginStore>
  );
};

export default App;
