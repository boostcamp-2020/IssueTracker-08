import React, { useState, useContext, useEffect } from 'react';
import styled from 'styled-components';
import { Dropdown } from 'semantic-ui-react';
import { CheckIcon } from '@primer/octicons-react';
import { IssueOpenedIcon } from '@primer/octicons-react';

import { IssueContext } from '../../../contexts/issueContext';

const HeaderContainer = styled.div`
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
  .check-icon {
    display: none !important;
    margin-right: 5px;
  }
  .show {
    display: inline-block !important;
  }
`;

const DropdownContainer = styled.div`
  font-size: 14px;
  padding-left: 16px;
  .dropdown {
    .dropdown-item {
      font-weight: 500;
      font-size: 13.5px;
      background: white;
      min-width: 150px;
    }
    .dropdown-menu {
      font-size: 15px;
      background: #f7f8fa;
      border: 1px solid #ebecef;
      .item:hover {
        background: #f7f8fa;
      }
    }
    .dropdown-header {
      // height: 10px;
      // display: flex;
      // position: relative;
      // bottom: 5px;
      font-size: 12px;
      display: flex;
      padding: 7px 7px 7px 16px;
      flex: none;
      align-items: center;
      border-bottom: 1px solid var(--color-select-menu-border-secondary);
  }
    }
    .dropdown-divider {
      margin: 0;
      border: none;
      border-top: 1px solid #e7e8ea;
    }
  }
`;

const ItemContainer = styled.div`
  display: flex;
  align-items: center;
  img {
    border-radius: 50% !important;
    width: 20px;
    height: 20px;
    object-fit: cover;
  }
`;

const Container = styled.div`
  display: flex;
  .HeaderIcon {
    margin-top: 2px;
    margin-left: 10px;
    margin-right: 3px;
  }
`;

const IssueNumSpan = styled.span`
  font-size: 14px;
  font-weight: bold;
  margin-left: 5px;
`;

const issueListHeader = () => {
  const { users, openIssues, closeIssues } = useContext(IssueContext);

  return (
    <HeaderContainer>
      <Container>
        <input type="checkbox" className="allIssue" />
        <IssueOpenedIcon className="HeaderIcon" size={16} />
        <IssueNumSpan>{openIssues.length} Open </IssueNumSpan>

        <CheckIcon size={16} className="HeaderIcon" />
        <IssueNumSpan>{closeIssues.length} Closed </IssueNumSpan>
      </Container>
      <FilterList>
        <DropdownContainer>
          <Dropdown className="author-dropdown dropdown" text="Author">
            <Dropdown.Menu className="dropdown-menu" direction="left">
              <Dropdown.Header
                className="dropdown-header"
                content="Filter by author"
              />
              {users &&
                users.map((item, index) => (
                  <>
                    <hr className="dropdown-divider" />
                    <Dropdown.Item
                      className="dropdown-item"
                      key={item.id}
                      value={index}
                    >
                      <ItemContainer>
                        <CheckIcon size={16} className="check-icon" />
                        <img src={item.imageUrl} />
                        <div>{item.name}</div>
                      </ItemContainer>
                    </Dropdown.Item>
                  </>
                ))}
            </Dropdown.Menu>
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
    </HeaderContainer>
  );
};

export default issueListHeader;