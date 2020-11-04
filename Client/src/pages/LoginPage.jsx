import React, { useState, Component } from 'react';
import styled from 'styled-components';
import { createGlobalStyle } from 'styled-components';

import './LoginPage.scss';
import * as config from '../config';

const GlobalStyle = createGlobalStyle`
  body {
    background-color: #f9f9f9;
  }
`

const Main = styled.div`
  display: flex;
`

const Container = styled.div`
  margin: auto;
  margin-top: 100px;
`

const Title = styled.div`
  text-align: center;
`

export default function LoginPage() {
  return (
    <>
      <Main>
        <Container>
          <Title>
            <h1>이슈 트래커</h1>
          </Title>

          <div class="login">
            <div class="id">
              <p>아이디</p>
              <input type="text"></input>
            </div>

            <div class="password">
              <p>비밀번호</p>
              <input type="password"></input>
            </div>

            <div class="routes">
              <a href="">로그인</a>
              <a href="">회원가입</a>
            </div>

            <a href={config.BASE_URL + "auth/github/"}>
              <div class="github-login">
                <p>Sign in with GitHub</p>
                <img src="/images/github.svg"></img>
              </div>
            </a>
          </div>
        </Container>
      </Main>
    <GlobalStyle />
    </>
  );
}
