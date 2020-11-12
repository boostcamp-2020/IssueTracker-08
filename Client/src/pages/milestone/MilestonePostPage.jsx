import React from 'react';
import styled from 'styled-components';

import MilestoneForm from '../../components/milestone/MilestoneForm';
import MilestonePostHeader from '../../components/milestone/MilestonePostHeader';
import Container from '../../components/shared/container/Container';

const Title = styled.p`
  font-size: 20px;
  font-weight: bold;
  margin: 0px;
`;

const Text = styled.p`
  color: #5d5d5d;
`;

export default function MilestonePostPage() {
  const description =
    'Create a new milestone to help organize you issues and pull requests. Learn more about milestones and issues.';

  return (
    <Container>
      <MilestonePostHeader>
        <Title>New Milestone</Title>
        <Text>{description}</Text>
      </MilestonePostHeader>
      <MilestoneForm link="/milestone" submit="Create milestone" />
    </Container>
  );
}
