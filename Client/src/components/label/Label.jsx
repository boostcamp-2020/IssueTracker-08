import React from 'react';
import styled from 'styled-components';
import { getFontColor } from '../../utils/color';

const Container = styled.div`
  display: inline;
  background-color: ${(props) => props.background};
  color: ${(props) => props.color};
  height: 20px;
  font-weight: bold;
  text-align: center;
  padding: 4px 8px;
  border-radius: 4px;
`;

const Label = (props) => {
  const fontColor = getFontColor(props.color);
  return (
    <Container background={props.color} color={fontColor}>
      {props.name}
    </Container>
  );
};

export default Label;
