import React from 'react';
import styled from 'styled-components';

const Header = styled.th`
  display: flex;
  align-items: center;
  width: 100%;
  height: 50px;
  border: 1px solid #ebecef;
  background: #ebecef;
  padding: 10px;
`;

const ItemHeader = (props) => {
  return <Header>{props.children}</Header>;
};

export default ItemHeader;
