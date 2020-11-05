import React from 'react';
import { createGlobalStyle } from 'styled-components';

import { Route, Switch, Redirect } from 'react-router-dom';
import { Home, About, LoginPage } from '../pages';

const GlobalStyle = createGlobalStyle`
  body {
    margin: 0px;
    padding: 0px;
  }
`;

const App = () => {
  return (
    <>
      <Route path="/login" component={LoginPage} />
      <Redirect from="*" to="/" />
      <GlobalStyle />
    </>
  );
};

export default App;
