import React from 'react';
import styled from 'styled-components';

import IssueListHeader from './issueListHeader';
import IssueListList from './issueList';

const Container = styled.div`
  margin-top: 20px;
`;

const IssueMain = () => {
  return (
    <Container>
      <IssueListHeader />
      <IssueListList />
    </Container>
  );
};

export default IssueMain;
