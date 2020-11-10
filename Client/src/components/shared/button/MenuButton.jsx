import React from 'react';
import styled, { css } from 'styled-components';
import { Link } from 'react-router-dom';

const ButtonContainer = styled.button`
  display: flex;
  justify-content: center;
  width: 140px;
  border-radius: 3px;
  border: 1px solid #dcdcdc;
  cursor: pointer;
  font-size: 15px;
  font-weight: bold;
  padding: 10px;
  text-decoration: none;
  background: white;
  ${(props) =>
    props.colorType === 'white' &&
    css`
      background: white;
      color: #666666;
    `};
  ${(props) =>
    props.colorType === 'blue' &&
    css`
      background: #1066d6;
      color: white;
    `};
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
        <ButtonContainer colorType={props.color}>
          <ButtonIcon src={props.img} />
          {props.name}
        </ButtonContainer>
      </StyledLink>
    </>
  );
};

export default MenuButton;
