import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';

import MenuButton from '../../components/shared/button/MenuButton';
import NewButton from '../../components/shared/button/NewButton';
import IssueListInfo from '../../components/issue/issueMain';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  padding: 60px 30px;
  width: 80%;
  max-width: 1400px;
  margin: auto;
`;

const IssueMenu = styled.div`
  display: flex;
  justify-content: space-between;
`;

const MenuDiv = styled.div`
  display: flex;
  flex: ${(props) => props.flex};
`;

const FilterButton = styled.button`
  box-shadow: inset 0px 1px 0px 0px #ffffff;
  background: linear-gradient(to bottom, #f9f9f9 5%, #e9e9e9 100%);
  background-color: #f9f9f9;
  border-radius: 3px;
  border: 1px solid #e8ecef;
  display: inline-block;
  cursor: pointer;
  color: #666666;
  font-family: Arial;
  font-size: 15px;
  font-weight: bold;
  padding: 6px 24px;
  text-decoration: none;
  text-shadow: 0px 1px 0px #ffffff;
`;

const FilterInput = styled.input`
  background: #fafbfc;
  border: 1px solid #e8ecef;
  flex: 1;
  margin-right: 20px;
  padding-left: 20px;
`;

export default function IssuePage() {
  return (
    <Container>
      <IssueMenu>
        <MenuDiv flex="1">
          <FilterButton>Filters</FilterButton>
          <FilterInput type="text" placeholder="🔎 Search all issue" />
        </MenuDiv>
        <MenuDiv flex="0">
          <MenuButton
            link="/label"
            name="Label"
            img="/images/label.svg"
          ></MenuButton>
          <MenuButton
            link="/milestone"
            name="Milestones"
            img="/images/milestone.svg"
          ></MenuButton>
        </MenuDiv>
        <MenuDiv flex="0">
          <NewButton link="/issue/post" name="issue" />
        </MenuDiv>
      </IssueMenu>
      <IssueListInfo />
    </Container>
  );
}
