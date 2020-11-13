import React from 'react';
import styled from 'styled-components';

const TitleStyle = styled.p`
  color: black;
  font-weight: bold;
  margin: 0px;
`;

const Title = ({ text }) => {
  return <TitleStyle>{text}</TitleStyle>;
};

export default Title;
