import React from 'react';
import styled from 'styled-components';

import IssueForm from '../../components/IssueForm';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 60px 30px;
  width: 80%;
  max-width: 1400px;
  margin: auto;
`;

export default function IssuePostPage() {
  return (
    <>
      <Container>
        <IssueForm />
      </Container>
    </>
  );
}
