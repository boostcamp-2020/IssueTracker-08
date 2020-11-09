import React from 'react';
import styled from 'styled-components';

import IssueList__Header from './issueListHeader';
import IssueList__List from './issueList';

const Container = styled.div`
  margin-top: 20px;
`;

const IssueMain = () => {
  return (
    <Container>
      <IssueList__Header />
      <IssueList__List />
    </Container>
  );
};

export default IssueMain;
