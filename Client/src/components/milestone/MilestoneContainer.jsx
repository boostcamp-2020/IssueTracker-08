import React, { useContext } from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

import { getTimeString } from '../../utils/time';
import { getMilestonePercent } from '../../utils/number';
import { MilestoneContext } from '../../stores/MilestoneStore';
import { putOptions } from '../../utils/fetchOptions';
import { PUT_MILESTONE_STATE } from '../../utils/api';

const Container = styled.div`
  display: flex;
  align-items: center;
  height: 100px;
  border: 1px solid #ebecef;
  background: white;
  padding: 10px 20px;
`;

const MilestoneInfoBox = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  flex: 1;
  height: 80%;
`;

const MilestoneGauge = styled.div`
  width: 100%;
  height: 16px;
  border: 0px;
  border-radius: 6px;
  background: linear-gradient(
    90deg,
    #28a745 ${(props) => props.open},
    #e6e6e6 0%
  );
`;

const RowInfoContainer = styled.div`
  display: flex;
`;

const Title = styled.p`
  margin: 0px;
  font-size: 20px;
`;

const Text = styled.p`
  margin: 0px;
  margin-right: 10px;
  font-size: 14px;
  color: #8c8c8c;
`;

const ActionButton = styled.button`
  border: transparent;
  background: transparent;
  padding: 0px;
  margin-right: 10px;
  color: ${(props) => props.color || 'blue'};
`;

const StyledLink = styled(Link)`
  color: blue;
  &:focus,
  &:hover,
  &:visited,
  &:link,
  &:active {
    text-decoration: none;
  }
`;

const MilestoneContainer = ({
  id,
  isOpen,
  title,
  content,
  dueDate,
  openIssue,
  closeIssue,
}) => {
  const { milestoneDispatch, updateMilestone } = useContext(MilestoneContext);
  const percent = getMilestonePercent(openIssue, openIssue + closeIssue);

  const closedMilestone = async () => {
    const body = {
      isOpen: 0,
    };
    const options = putOptions(body);
    await fetch(PUT_MILESTONE_STATE(id), options);

    milestoneDispatch({
      type: 'CLOSED_MILESTONE',
      payload: id,
      update: updateMilestone,
    });
  };

  const reopenMilestone = async () => {
    const body = {
      isOpen: 1,
    };
    const options = putOptions(body);
    await fetch(PUT_MILESTONE_STATE(id), options);

    milestoneDispatch({
      type: 'REOPEN_MILESTONE',
      payload: id,
      update: updateMilestone,
    });
  };

  return (
    <Container>
      <MilestoneInfoBox>
        <Title>{title}</Title>
        <Text>{getTimeString(dueDate)}</Text>
        <Text>{content}</Text>
      </MilestoneInfoBox>
      <MilestoneInfoBox>
        <MilestoneGauge open={percent} />
        <RowInfoContainer>
          <Text>{percent + ' complete'}</Text>
          <Text>{openIssue + ' open'}</Text>
          <Text>{closeIssue + ' closed'}</Text>
        </RowInfoContainer>
        <RowInfoContainer>
          <ActionButton>
            <StyledLink to={'/milestone/edit/' + id}>Edit</StyledLink>
          </ActionButton>
          {isOpen ? (
            <ActionButton onClick={closedMilestone}>Close</ActionButton>
          ) : (
            <ActionButton onClick={reopenMilestone}>ReOpen</ActionButton>
          )}
          <ActionButton color="red">Delete</ActionButton>
        </RowInfoContainer>
      </MilestoneInfoBox>
    </Container>
  );
};

export default MilestoneContainer;
