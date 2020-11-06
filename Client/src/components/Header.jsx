import React from 'react';
import styled from 'styled-components';

const Wrapper = styled.div`
  display: flex;
  justify-content: center;
  align-items: center;
  background: #24292f;
  height: 80px;
`;

const Title = styled.p`
  color: white;
  font-weight: bold;
  font-size: 20px;
`;

const Header = () => {
  return (
    <Wrapper>
      <Title>🐼ISSUES</Title>
    </Wrapper>
  );
};

export default Header;
