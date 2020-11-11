import React, { useContext } from 'react';
import { Route, Redirect } from 'react-router-dom';
import { LoginContext } from '../stores/LoginStore';
import { LoginPage, Callback } from '../pages';

export default function LoginRouter() {
  const { isLoggedIn } = useContext(LoginContext);
  const loginRouter = (
    <>
      <Route path="/" component={LoginPage} />
      <Route path="/auth" component={Callback} />
      <Redirect from="*" to="/" />
    </>
  );

  return isLoggedIn ? <></> : loginRouter;
}
