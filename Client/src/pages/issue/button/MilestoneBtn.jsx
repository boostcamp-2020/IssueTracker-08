import React, { useContext } from 'react';
import { MilestoneIcon } from '@primer/octicons-react';
import { useHistory } from 'react-router-dom';
import styled from 'styled-components';

import { IssueContext } from '../../../stores/IssueStore';

const ButtonDesign = styled.button`
  display: flex;
  box-sizing: border-box;
  min-width: 80px;
  border: 1px solid #dcdcdc;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 600;
  padding: 0px 13px;
  cursor: pointer;
  outline: none;
`;

const MilestoneButton = styled(ButtonDesign)`
  border-radius: 0 4px 4px 0;
  background: #ffffff;
  color: #606060;
  border-right: 1px solid #e0e0e0;
`;

const ButtonText = styled.p`
  margin: 0 5px;
`;

const ShowTotalNum = styled.span`
  padding: 3px 6px;
  background: #f2f2f2;
  border-radius: 50px;
`;

export default function MilestoneBtn() {
  const history = useHistory();
  const { milestones } = useContext(IssueContext);

  return (
    <MilestoneButton onClick={() => history.push('/milestone')}>
      <MilestoneIcon size={14} />
      <ButtonText>Milestones</ButtonText>
      <ShowTotalNum>{milestones ? milestones.length : 0}</ShowTotalNum>
    </MilestoneButton>
  );
}
