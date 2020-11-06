import React, { useState, Component } from 'react';
import styled from 'styled-components';
import { createGlobalStyle } from 'styled-components';
import { Link } from 'react-router-dom';

import * as config from '../../config';

const GlobalStyle = createGlobalStyle`
  body {
    background-color: #f9f9f9;
  }
`;

const Main = styled.div`
  display: flex;
`;

const Container = styled.div`
  margin: auto;
  margin-top: 100px;
`;

const Title = styled.div`
  text-align: center;
`;

const LoginForm = styled.div`
  background-color: white;
  border: solid 1px #dce1e5;
  border-radius: 5px;
  font-weight: bold;
  font-size: 14px;
  padding: 10px 19px 22px 19px;
`;

const Input = styled.input`
  border: solid 2px #e4e6ea;
  border-radius: 3px;
  box-shadow: 3px;
  width: 230px;
  height: 25px;
`;

const Routes = styled.div`
  display: flex;
  justify-content: space-around;
  margin-top: 10px;
`;

const StyledLink = styled(Link)`
  color: #126fd8;
  &:focus,
  &:hover,
  &:visited,
  &:link,
  &:active {
    text-decoration: none;
  }
`;

const GithubLink = styled.a`
  text-decoration: none;
`;

const GithubLogin = styled.div`
  display: flex;
  text-align: center;
  background-color: #a0a0a0;
  border: solid 1px #989898;
  border-radius: 5px;
  height: 35px;
  margin-top: 20px;
`;
const GithubContent = styled.p`
  color: white;
  font-weight: bold;
  margin: auto;
  margin-top: 8px;
  margin-left: 40px;
`;

const GithubImage = styled.img`
  padding-right: 30px;
`;

export default function LoginPage() {
  return (
    <>
      <Main>
        <Container>
          <Title>
            <h1>이슈 트래커</h1>
          </Title>

          <LoginForm>
            <div>
              <p>아이디</p>
              <Input type="text" />
            </div>

            <div>
              <p>비밀번호</p>
              <Input type="password" />
            </div>

            <Routes>
              <StyledLink to="/login">로그인</StyledLink>
              <StyledLink to="/login">회원가입</StyledLink>
            </Routes>

            <GithubLink href={config.BASE_URL + 'auth/github/'}>
              <GithubLogin>
                <GithubContent>Sign in with GitHub</GithubContent>
                <GithubImage src="/images/github.svg"></GithubImage>
              </GithubLogin>
            </GithubLink>
          </LoginForm>
        </Container>
      </Main>
      <GlobalStyle />
    </>
  );
}
