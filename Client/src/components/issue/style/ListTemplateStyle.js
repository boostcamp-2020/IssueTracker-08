import styled from 'styled-components';

export default {
  Container: styled.div`
    display: flex;
    padding: 8px 16px;
    border: 1px solid #e1e4e8;
    border-top: 0;
    .issueCheckbox {
      margin-top: 5px;
    }
    .title:hover {
      color: #0366d6;
      cursor: pointer;
    }
    &:hover {
      background: #f7f8fa;
    }
    &:last-of-type {
      border-bottom-left-radius: 6px;
      border-bottom-right-radius: 6px;
    }
  `,
  IssueContainer: styled.div`
    padding: 0 8px;
    .titleContainer {
      display: flex;
      .title {
        font-weight: bold;
      }
    }
  `,
  LabelList: styled.div`
    display: flex;
    .label {
      padding: 0 7px;
      margin-left: 10px;
      border: 1px solid transparent;
      color: #fff;
      border-radius: 2rem;
      background-color: #6b6bce;
      font-size: 12px;
      font-weight: 500;
    }
  `,
  LogContainer: styled.div`
    color: #586069;
    display: flex;
    margin-top: 5px;
    font-size: 12px;
    .author {
      margin-left: 5px;
    }
    .author:hover {
      color: #0366d6;
      cursor: pointer;
    }
  `,
};
