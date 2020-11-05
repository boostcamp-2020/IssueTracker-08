import React from 'react';
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
} from '../pages';
import Header from '../components/Header';

const GlobalStyle = createGlobalStyle`
  body {
    margin: 0px;
    padding: 0px;
  }
`;

const App = () => {
  const isLoggedIn = true; // TODO : setLoginState
  if (isLoggedIn) {
    return (
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
  }
  return (
    <>
      <Route path="/" component={LoginPage} />
      <Redirect from="*" to="/" />
      <GlobalStyle />
    </>
  );
};

export default App;
