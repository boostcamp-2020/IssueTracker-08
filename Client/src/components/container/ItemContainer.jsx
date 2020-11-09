import React from 'react';
import styled from 'styled-components';

const Container = styled.div`
  width: 100%;
  border: 0px solid #ebecef;
  border-radius: 4px;
  padding: 0px;
  margin-top: 30px;
`;

const ItemContainer = (props) => {
  return <Container>{props.children}</Container>;
};

export default ItemContainer;
