import React from 'react';
import { Route, Switch } from 'react-router-dom';
import {
  Issue,
  IssueDetail,
  IssuePost,
  Label,
  Milestone,
  MilestonePost,
} from '../pages';
import Header from '../components/Header';
import LoginPage from '../pages/login/LoginPage';

const App = () => {
  const isLoggedIn = true; // TODO : setLoginState
  if (isLoggedIn) {
    return (
      <div>
        <Header></Header>
        <Route exact path="/" component={Issue} />
        <Switch>
          <Route path="/issue/post" component={IssuePost} />
          <Route path="/issue/:issueId" component={IssueDetail} />
          <Route path="/label" component={Label} />
          <Route path="/milestone/post" component={MilestonePost} />
          <Route path="/milestone" component={Milestone} />
        </Switch>
      </div>
    );
  }
  return <LoginPage />;
};

export default App;
