import React from 'react';
import styled from 'styled-components';
import MenuButton from '../button/MenuButton';

const MenuDiv = styled.div`
  display: flex;
  margin-bottom: 20px;
`;

const Menu = ({ name, children }) => {
  return (
    <MenuDiv>
      <MenuButton
        link="/label"
        name="Label"
        img="/images/label.svg"
        color={name === 'label' ? 'blue' : 'white'}
      ></MenuButton>
      <MenuButton
        link="/milestone"
        name="Milestones"
        img="/images/milestone.svg"
        color={name === 'milestone' ? 'blue' : 'white'}
      ></MenuButton>
      {children}
    </MenuDiv>
  );
};

export default Menu;
