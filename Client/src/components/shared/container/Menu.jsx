import React from 'react';
import styled from 'styled-components';
import NewButton from '../button/NewButton';
import MenuButton from '../button/MenuButton';

const MenuDiv = styled.div`
  display: flex;
`;

const Menu = (props) => {
  return (
    <MenuDiv>
      <MenuButton
        link="/label"
        name="Label"
        img="/images/label.svg"
        color={props.name === 'label' ? 'blue' : 'white'}
      ></MenuButton>
      <MenuButton
        link="/milestone"
        name="Milestones"
        img="/images/milestone.svg"
        color={props.name === 'milestone' ? 'blue' : 'white'}
      ></MenuButton>
      <NewButton link={props.link} name={props.name} />
    </MenuDiv>
  );
};

export default Menu;
