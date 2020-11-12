import React from 'react';
import MilestoneContainer from './MilestoneContainer';

const MilestoneList = () => {
  const milestones = [
    {
      id: 11,
      title: '마일스톤 제목',
      dueDate: '2020-11-30T15:00:00.000Z',
      content: '마일스톤의 내용',
      isOpen: 1,
      createAt: '2020-11-06T06:39:55.000Z',
      openIssue: 3,
      closeIssue: 1,
    },
  ];

  const milestoneList = milestones.map((milestone) => (
    <MilestoneContainer
      key={milestone.id}
      id={milestone.id}
      isOpen={milestone.isOpen}
      title={milestone.title}
      content={milestone.content}
      dueDate={milestone.dueDate}
      openIssue={milestone.openIssue}
      closeIssue={milestone.closeIssue}
    />
  ));
  return <>{milestoneList}</>;
};

export default MilestoneList;
