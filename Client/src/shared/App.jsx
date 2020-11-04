import React from 'react';
import { Route, Switch } from 'react-router-dom';
import { Home, About } from '../pages';
import Menu from '../components/Menu';
import LoginPage from '../pages/login/LoginPage';

const App = () => {
  const isLoggedIn = true; // TODO : setLoginState
  if (isLoggedIn) {
    return (
      <div>
        <Menu></Menu>
        <Route exact path="/" component={Home} />
        <Switch>
          <Route path="/about/:name" component={About} />
          <Route path="/about" component={About} />
        </Switch>
      </div>
    );
  }
  return <LoginPage />;
};

export default App;
