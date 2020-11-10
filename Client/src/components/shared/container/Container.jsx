import React from 'react';
import styled from 'styled-components';

const ContainerDiv = styled.div`
  display: flex;
  flex-direction: column;
  padding: 60px 30px;
  width: 80%;
  max-width: 1400px;
  margin: auto;
`;

const Container = (props) => {
  return <ContainerDiv>{props.children}</ContainerDiv>;
};

export default Container;
