import React, { useEffect, useState } from 'react';
import { Route, Redirect, Switch } from 'react-router-dom';
import { createGlobalStyle } from 'styled-components';
import {
  Issue,
  IssueDetail,
  IssuePost,
  Label,
  Milestone,
  MilestonePost,
  LoginPage,
  Callback,
} from '../pages';
import Header from '../components/Header';

import { GET_AUTH } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';

const GlobalStyle = createGlobalStyle`
  body {
    margin: 0px;
    padding: 0px;
  }
`;

const App = () => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const checkValidLogin = async () => {
    const response = await fetch(GET_AUTH, getOptions);

    if (response.status === 200) {
      setIsLoggedIn(true);
    } else {
      setIsLoggedIn(false);
    }
  };

  useEffect(() => {
    checkValidLogin();
  });

  const mainRouter = (
    <>
      <Header></Header>
      <Route exact path="/" component={Issue} />
      <Switch>
        <Route path="/issue/post" component={IssuePost} />
        <Route path="/issue/:issueId" component={IssueDetail} />
        <Route path="/label" component={Label} />
        <Route path="/milestone/post" component={MilestonePost} />
        <Route path="/milestone" component={Milestone} />
        <Redirect from="*" to="/" />
      </Switch>
      <GlobalStyle />
    </>
  );

  const loginRouter = (
    <>
      <Header></Header>
      <Route path="/" component={LoginPage} />
      <Route path="/auth" component={Callback} />
      <Redirect from="*" to="/" />
      <GlobalStyle />
    </>
  );

  return isLoggedIn ? mainRouter : loginRouter;
};

export default App;
