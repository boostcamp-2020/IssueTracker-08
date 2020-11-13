import React, { useContext } from 'react';
import { Route, Redirect, Switch } from 'react-router-dom';
import { LoginContext } from '../stores/LoginStore';
import {
  Issue,
  IssueDetail,
  IssuePost,
  Label,
  Milestone,
  MilestonePost,
  MilestoneEdit,
} from '../pages';

export default function MainRouter() {
  const { isLoggedIn } = useContext(LoginContext);
  const mainRouter = (
    <>
      <Route exact path="/" component={Issue} />
      <Switch>
        <Route path="/issue/post" component={IssuePost} />
        <Route path="/issue/:issueId" component={IssueDetail} />
        <Route path="/label" component={Label} />
        <Route path="/milestone/post" component={MilestonePost} />
        <Route path="/milestone/edit/:milestoneId" component={MilestoneEdit} />
        <Route path="/milestone" component={Milestone} />
        <Redirect from="*" to="/" />
      </Switch>
    </>
  );
  return isLoggedIn ? mainRouter : <></>;
}
