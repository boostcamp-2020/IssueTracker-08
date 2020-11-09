import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

const Button = styled.button`
  min-width: 120px;
  box-shadow: 0px 1px 0px 0px #3dc21b;
  background: linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%);
  background-color: #44c767;
  border-radius: 6px;
  border: 1px solid #18ab29;
  display: inline-block;
  cursor: pointer;
  color: white;
  font-size: 15px;
  font-weight: bold;
  padding: 10px;
  text-decoration: none;
  text-shadow: 0px -1px 0px #2f6627;
  margin-left: 20px;
`;

const StyledLink = styled(Link)`
  margin-left: auto;
`;

const NewButton = (props) => {
  return (
    <>
      <StyledLink to={props.link}>
        <Button>{'New ' + props.name}</Button>
      </StyledLink>
    </>
  );
};

export default NewButton;
