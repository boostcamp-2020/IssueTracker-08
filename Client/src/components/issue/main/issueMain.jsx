import React from 'react';
import styled from 'styled-components';

import IssueListHeader from './issueListHeader';
import IssueListList from './issueList';
import IssuesStore from '../../../contexts/issueContext';

const Container = styled.div`
  margin-top: 20px;
`;

const IssueMain = () => {
  return (
    <IssuesStore>
      <Container>
        <IssueListHeader />
        <IssueListList />
      </Container>
    </IssuesStore>
  );
};

export default IssueMain;
