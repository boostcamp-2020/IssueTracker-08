import React from 'react';
import { Route, Switch } from 'react-router-dom';
import { Home, About } from '../pages';
import Menu from '../components/Menu'

const App = () => {
  return (
    <div>
      <Menu></Menu>
      <Route exact path="/" component={Home}/>
      <Switch>
        <Route path="/about/:name" component={About}/>
        <Route path="/about" component={About}/>
      </Switch>
    </div>
  );
};

export default App;
