import React, { useState, Component } from 'react';
import './LoginPage.scss';
export default function LoginPage() {
  return (
      <div class="container">
        <div class="title">
          <h1>이슈 트래커</h1>
        </div>

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

          <a href="http://127.0.0.1:8080/auth/github/">
            <div class="github-login">
              <p>Sign in with GitHub</p>
              <img src="/images/github.svg"></img>
            </div>
          </a>
        </div>

      </div>
  );
}
