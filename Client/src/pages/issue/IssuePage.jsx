import React from 'react';
import styled from 'styled-components';
import { Link } from 'react-router-dom';
import MenuButton from '../../components/MenuButton';

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

const IssueList = styled.div`
  display: flex;
  width: 100%;
  border: 1px solid #ebecef;
  border-radius: 4px;
  padding: 10px;
  margin-top: 30px;
`;

const MenuDiv = styled.div`
  display: flex;
  flex: ${(props) => props.flex};
`;

const IssueButton = styled.button`
  width: 120px;
  box-shadow: 0px 1px 0px 0px #3dc21b;
  background: linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%);
  background-color: #44c767;
  border-radius: 6px;
  border: 1px solid #18ab29;
  display: inline-block;
  cursor: pointer;
  color: white;
  font-size: 15px;
  font-weight: bold;
  padding: 10px;
  text-decoration: none;
  text-shadow: 0px -1px 0px #2f6627;
  margin-left: 20px;
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
          <Link to="/issue/post">
            <IssueButton>New issue</IssueButton>
          </Link>
        </MenuDiv>
      </IssueMenu>
      <IssueList>
        <div>TODO : 이슈 목록 코드를 구현해주세요.</div>
      </IssueList>
    </Container>
  );
}
