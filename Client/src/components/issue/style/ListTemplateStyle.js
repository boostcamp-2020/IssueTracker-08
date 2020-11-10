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
    .issueOpenedIcon {
      margin-top: 4px;
      margin-left: 10px;
      color: #22863a;
    }
    .issueClosedIcon {
      margin-top: 4px;
      margin-left: 10px;
      color: #cb2431;
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
      padding: 2px 10px;
      margin-left: 7px;
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
  MilestoneContainer: styled.div`
    display: flex;
    margin-left: 8px;
    .milestoneIcon {
      color: #959da5;
      vertical-align: bottom;
    }
    .milestone {
      margin-left: 4px;
    }
    &:hover {
      cursor: pointer;
    }
  `,
};
