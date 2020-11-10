import React from 'react';
import {
  IssueOpenedIcon,
  MilestoneIcon,
  IssueClosedIcon,
} from '@primer/octicons-react';
import { useHistory } from 'react-router-dom';

import Style from './style/ListTemplateStyle';

const issueListTemplate = ({ issue }) => {
  const history = useHistory();

  return (
    <Style.Container>
      {' '}
      <input type="checkbox" className="issueCheckbox" />
      {issue.isOpen === 1 ? (
        <IssueOpenedIcon className="issueOpenedIcon" size={16} />
      ) : (
        <IssueClosedIcon className="issueClosedIcon" size={16} />
      )}
      <Style.IssueContainer>
        <div className="titleContainer">
          <div
            className="title"
            onClick={() => {
              history.push(`issue/${issue.issueId}`);
            }}
          >
            {issue.title}
          </div>
          <Style.LabelList>
            {issue.label &&
              issue.label.map((label) => (
                <div style={{ background: label.labelColor }} className="label">
                  {label.labelName}
                </div>
              ))}
          </Style.LabelList>
        </div>
        <Style.LogContainer>
          #{issue.issueId}
          {issue.isOpen === 1 ? '  opened' : '  was closed'} 5 hours ago by
          <span className="author"> {issue.name}</span>
          {issue.milestone && (
            <Style.MilestoneContainer>
              <MilestoneIcon className="milestoneIcon" size={16} />{' '}
              <div className="milestone"> {issue.milestone}</div>
            </Style.MilestoneContainer>
          )}
        </Style.LogContainer>
      </Style.IssueContainer>
    </Style.Container>
  );
};

export default issueListTemplate;
