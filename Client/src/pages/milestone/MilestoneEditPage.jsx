import React from 'react';
import { useHistory } from 'react-router-dom';
import styled from 'styled-components';

import MilestoneForm from '../../components/milestone/MilestoneForm';
import MilestonePostHeader from '../../components/milestone/MilestonePostHeader';
import Container from '../../components/shared/container/Container';

const CancelButton = styled.button`
  box-shadow: inset 0px 1px 0px 0px #ffffff;
  background: linear-gradient(to bottom, #f9f9f9 5%, #e9e9e9 100%);
  background-color: #f9f9f9;
  border-radius: 6px;
  border: 1px solid #e8ecef;
  display: inline-block;
  cursor: pointer;
  color: #666666;
  font-family: Arial;
  font-size: 15px;
  font-weight: bold;
  padding: 6px 24px;
  text-decoration: none;
  text-shadow: 0px 1px 0px #ffffff;
`;

export default function MilestoneEditPage({ match }) {
  const history = useHistory();
  const milestoneId = match.params.milestoneId;

  const cancelEdit = () => {
    history.push('/milestone');
  };

  return (
    <Container>
      <MilestonePostHeader>Edit Milestone</MilestonePostHeader>
      <MilestoneForm type="EDIT" submit="Save changes" id={milestoneId}>
        <CancelButton onClick={cancelEdit}>Cancel</CancelButton>
      </MilestoneForm>
    </Container>
  );
}
