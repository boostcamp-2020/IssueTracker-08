import React, { useContext } from 'react';
import { MilestoneContext } from '../../stores/MilestoneStore';
import MilestoneContainer from './MilestoneContainer';

const MilestoneList = () => {
  const { milestones, loading, isOpenClicked } = useContext(MilestoneContext);

  const milestoneTemplate = (milestone) => {
    if (
      (isOpenClicked && milestone.isOpen) ||
      (!isOpenClicked && !milestone.isOpen)
    ) {
      return (
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
      );
    }
  };

  let milestoneList = <div>Loading...</div>;
  if (!loading) {
    milestoneList = milestones.map((milestone) => milestoneTemplate(milestone));
  }

  return <>{milestoneList}</>;
};

export default MilestoneList;
