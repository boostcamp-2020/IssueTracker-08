import React, { useContext } from 'react';
import { MilestoneContext } from '../../stores/MilestoneStore';
import MilestoneContainer from './MilestoneContainer';

const MilestoneList = () => {
  const { milestones, loading } = useContext(MilestoneContext);
  let milestoneList = <div>Loading...</div>;
  if (!loading) {
    milestoneList = milestones.map((milestone) => (
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
  }

  return <>{milestoneList}</>;
};

export default MilestoneList;
