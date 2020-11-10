import React from 'react';
import {
  IssueOpenedIcon,
  MilestoneIcon,
  IssueClosedIcon,
} from '@primer/octicons-react';
import styled from 'styled-components';
import { useHistory } from 'react-router-dom';

import getDiffTime from '../../../utils/getDiffTime';

const Container = styled.div`
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
`;

const IssueContainer = styled.div`
  padding: 0 8px;
  .titleContainer {
    display: flex;
    .title {
      font-weight: bold;
    }
  }
`;

const LabelList = styled.div`
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
`;

const LogContainer = styled.div`
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
`;

const MilestoneContainer = styled.div`
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
`;

const issueListTemplate = ({ issue }) => {
  const history = useHistory();

  return (
    <Container>
      {' '}
      <input type="checkbox" className="issueCheckbox" />
      {issue.isOpen === 1 ? (
        <IssueOpenedIcon className="issueOpenedIcon" size={16} />
      ) : (
        <IssueClosedIcon className="issueClosedIcon" size={16} />
      )}
      <IssueContainer>
        <div className="titleContainer">
          <div
            className="title"
            onClick={() => {
              history.push(`issue/${issue.issueId}`);
            }}
          >
            {issue.title}
          </div>
          <LabelList>
            {issue.label &&
              issue.label.map((label) => (
                <div style={{ background: label.labelColor }} className="label">
                  {label.labelName}
                </div>
              ))}
          </LabelList>
        </div>
        <LogContainer>
          #{issue.issueId}
          {issue.isOpen === 1 ? '  opened' : '  was closed'}{' '}
          {getDiffTime(issue.createAt)} ago by
          <span className="author"> {issue.name}</span>
          {issue.milestone && (
            <MilestoneContainer>
              <MilestoneIcon className="milestoneIcon" size={16} />
              <div className="milestone"> {issue.milestone}</div>
            </MilestoneContainer>
          )}
        </LogContainer>
      </IssueContainer>
    </Container>
  );
};

export default issueListTemplate;
