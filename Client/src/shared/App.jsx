import React from 'react';
import styled from 'styled-components';
import { createGlobalStyle } from 'styled-components';

import { Route, Switch } from 'react-router-dom';
import { Home, About, LoginPage } from '../pages';

const GlobalStyle = createGlobalStyle`
  body {
    margin: 0px;
    padding: 0px;
  }
`

const App = () => {
  return (
    <>
      <Route exact path="/" component={Home}/>
      <Route path="/login" component={LoginPage}/>
      <Switch>
        <Route path="/about/:name" component={About}/>
        <Route path="/about" component={About}/>
      </Switch>
      <GlobalStyle />
    </>
  );
};

export default App;
