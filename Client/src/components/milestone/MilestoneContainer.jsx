import React from 'react';
import styled from 'styled-components';
import { getMilestonePercent } from '../../utils/number';

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

const MilestoneContainer = ({
  id,
  isOpen,
  title,
  content,
  dueDate,
  openIssue,
  closeIssue,
}) => {
  const percent = getMilestonePercent(openIssue, openIssue + closeIssue);
  return (
    <Container>
      <MilestoneInfoBox>
        <Title>{title}</Title>
        <Text>{dueDate}</Text>
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
          <ActionButton>Edit</ActionButton>
          <ActionButton>Close</ActionButton>
          <ActionButton color="red">Delete</ActionButton>
        </RowInfoContainer>
      </MilestoneInfoBox>
    </Container>
  );
};

export default MilestoneContainer;
