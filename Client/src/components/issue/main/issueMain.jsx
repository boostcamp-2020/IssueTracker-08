import React from 'react';
import styled from 'styled-components';

import IssueList__Header from './issueListHeader';
import IssueList__List from './issueList';
import IssuesStore from '../../../context/issueContext';

const Container = styled.div`
  margin-top: 20px;
`;

const IssueMain = () => {
  return (
    <IssuesStore>
      <Container>
        <IssueList__Header />
        <IssueList__List />
      </Container>
    </IssuesStore>
  );
};

export default IssueMain;
