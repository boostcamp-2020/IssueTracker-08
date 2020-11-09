import React from 'react';
import { useHistory } from 'react-router-dom';

import Style from './style/ListTemplateStyle';

const issueListTemplate = ({ issue }) => {
  const history = useHistory();

  return (
    <Style.Container>
      {' '}
      <input type="checkbox" className="issueCheckbox" />
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
        </Style.LogContainer>
      </Style.IssueContainer>
    </Style.Container>
  );
};

export default issueListTemplate;
