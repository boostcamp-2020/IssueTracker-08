import React from 'react';
import { Dropdown } from 'semantic-ui-react';

import Style from './style/HeaderStyle';

const issueListHeader = () => {
  return (
    <Style.ListContainer>
      <input type="checkbox" className="allIssue" />
      <Style.FilterList>
        <Style.DropdownContainer>
          <Dropdown text="Author">
            <Dropdown.Menu direction="left"></Dropdown.Menu>
          </Dropdown>
        </Style.DropdownContainer>

        <Style.DropdownContainer>
          <Dropdown text="Label">
            <Dropdown.Menu direction="left"></Dropdown.Menu>
          </Dropdown>
        </Style.DropdownContainer>

        <Style.DropdownContainer>
          <Dropdown text="Milestones">
            <Dropdown.Menu direction="left"></Dropdown.Menu>
          </Dropdown>
        </Style.DropdownContainer>

        <Style.DropdownContainer>
          <Dropdown text="Assignee">
            <Dropdown.Menu direction="left"></Dropdown.Menu>
          </Dropdown>
        </Style.DropdownContainer>
      </Style.FilterList>
    </Style.ListContainer>
  );
};

export default issueListHeader;
