import React from 'react';
import styled from 'styled-components';
import { Dropdown } from 'semantic-ui-react';

const ListContainer = styled.div`
  display: flex;
  height: 15px;
  justify-content: space-between;
  border: 1px solid #ebecef;
  border-top-left-radius: 6px;
  border-top-right-radius: 6px;
  background-color: #f6f8fa;
  padding: 16px;
  position: relative;
`;

const FilterList = styled.div`
  display: flex;
`;

const DropdownContainer = styled.div`
  font-size: 14px;
  padding-left: 16px;
`;

const issueListHeader = () => {
  return (
    <ListContainer>
      <input type="checkbox" className="allIssue" />
      <FilterList>
        <DropdownContainer>
          <Dropdown text="Author">
            <Dropdown.Menu direction="left"></Dropdown.Menu>
          </Dropdown>
        </DropdownContainer>

        <DropdownContainer>
          <Dropdown text="Label">
            <Dropdown.Menu direction="left"></Dropdown.Menu>
          </Dropdown>
        </DropdownContainer>

        <DropdownContainer>
          <Dropdown text="Milestones">
            <Dropdown.Menu direction="left"></Dropdown.Menu>
          </Dropdown>
        </DropdownContainer>

        <DropdownContainer>
          <Dropdown text="Assignee">
            <Dropdown.Menu direction="left"></Dropdown.Menu>
          </Dropdown>
        </DropdownContainer>
      </FilterList>
    </ListContainer>
  );
};

export default issueListHeader;
