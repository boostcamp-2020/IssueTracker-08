import React, { useContext } from 'react';
import { MilestoneIcon, CheckIcon } from '@primer/octicons-react';
import styled from 'styled-components';

import { MilestoneContext } from '../../stores/MilestoneStore';

const MilestoneMenuContainer = styled.div`
  display: flex;
  margin: 0px 6px;
  align-items: center;
`;

const MenuDiv = styled.div`
  color: ${(props) => props.color};
  button {
    color: ${(props) => props.color};
    border: transparent;
    background: transparent;
    font-size: 14px;
    margin-left: 0px;
  }
`;

const MilestoneHeaderMenu = () => {
  const { isOpenClicked, setIsOpenClicked, open, closed } = useContext(
    MilestoneContext
  );

  const openOpenMilestone = () => {
    setIsOpenClicked(true);
  };

  const openClosedMilestone = () => {
    setIsOpenClicked(false);
  };

  return (
    <>
      <MilestoneMenuContainer>
        <MenuDiv color={isOpenClicked ? 'black' : 'gray'}>
          <MilestoneIcon />
          <button onClick={openOpenMilestone}>{open + ' Open'}</button>
        </MenuDiv>
      </MilestoneMenuContainer>
      <MilestoneMenuContainer>
        <MenuDiv color={isOpenClicked ? 'gray' : 'black'}>
          <CheckIcon />
          <button onClick={openClosedMilestone}>{closed + ' Closed'}</button>
        </MenuDiv>
      </MilestoneMenuContainer>
    </>
  );
};

export default MilestoneHeaderMenu;
