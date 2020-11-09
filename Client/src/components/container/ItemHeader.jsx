import React from 'react';
import styled from 'styled-components';

const Header = styled.div`
  display: flex;
  align-items: center;
  height: 40px;
  border: 1px solid #ebecef;
  background: #f6f8fa;
  padding: 10px;
`;

const ItemHeader = (props) => {
  return <Header>{props.children}</Header>;
};

export default ItemHeader;
