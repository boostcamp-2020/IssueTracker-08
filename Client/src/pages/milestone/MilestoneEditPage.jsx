import React from 'react';

import MilestoneForm from '../../components/milestone/MilestoneForm';
import MilestonePostHeader from '../../components/milestone/MilestonePostHeader';
import Container from '../../components/shared/container/Container';

export default function MilestoneEditPage({ match }) {
  const milestoneId = match.params.milestoneId;

  return (
    <Container>
      <MilestonePostHeader>Edit Milestone</MilestonePostHeader>
      <MilestoneForm type="EDIT" submit="Save changes" id={milestoneId} />
    </Container>
  );
}
