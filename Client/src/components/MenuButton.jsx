import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

const ButtonContainer = styled.button`
  display: flex;
  justify-content: center;
  width: 140px;
  background-color: white;
  border-radius: 3px;
  border: 1px solid #dcdcdc;
  cursor: pointer;
  color: #666666;
  font-size: 15px;
  font-weight: bold;
  padding: 10px;
  text-decoration: none;
  text-shadow: 0px 1px 0px #ffffff;
`;

const ButtonIcon = styled.img`
  width: 20px;
  margin-right: 10px;
`;

const StyledLink = styled(Link)`
  text-decoration: none;
  &:focus,
  &:hover,
  &:visited,
  &:link,
  &:active {
    text-decoration: none;
  }
`;

const MenuButton = (props) => {
  return (
    <>
      <StyledLink to={props.link}>
        <ButtonContainer>
          <ButtonIcon src={props.img} />
          {props.name}
        </ButtonContainer>
      </StyledLink>
    </>
  );
};

export default MenuButton;
