import React from 'react';
import { Route, Redirect, Switch } from 'react-router-dom';
import {
  Issue,
  IssueDetail,
  IssuePost,
  Label,
  Milestone,
  MilestonePost,
} from './';
import Header from '../components/Header';

export default function MainPage() {
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
        <Redirect from="*" to="/" />
      </Switch>
    </div>
  );
}
