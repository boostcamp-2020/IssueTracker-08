import React from 'react';
import styled from 'styled-components';

const Container = styled.table`
  display: flex;
  width: 100%;
  border: 1px solid #ebecef;
  border-radius: 4px;
  margin-top: 30px;
`;

const ItemContainer = (props) => {
  return <Container>{props.children}</Container>;
};

export default ItemContainer;
