import React from 'react';
import styled from 'styled-components';

const TitleStyle = styled.p`
  color: black;
  weight: bold;
  margin: 0px;
`;

const Title = (prop) => {
  return <TitleStyle>{prop.text}</TitleStyle>;
};

export default Title;
