import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

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
      <Link to="/" style={{ textDecoration: 'none' }}>
        <Title>🐼ISSUES</Title>
      </Link>
    </Wrapper>
  );
};

export default Header;
