import React, { useContext } from 'react';
import styled from 'styled-components';
import { Dropdown } from 'semantic-ui-react';
import { CheckIcon } from '@primer/octicons-react';
import { IssueOpenedIcon } from '@primer/octicons-react';

import { IssueContext } from '../../../stores/IssueStore';
import { UserContext } from '../../../stores/UserStore';
import { GET_OPEN_ISSUE, GET_CLOSED_ISSUE } from '../../../utils/api';
import { getOptions } from '../../../utils/fetchOptions';

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
      display: none;
      font-size: 15px;
      background: #f7f8fa;
      border: 1px solid #ebecef;
      .item:hover {
        background: #f7f8fa;
      }
    }

    .visible {
      display: inline-block !important;
    }

    .dropdown-header {
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

    .show {
      display: inline-block !important;
    }
  }
`;

const ItemContainer = styled.div`
  display: flex;
  align-items: center;
  img {
    margin-right: 8px;
    border-radius: 50% !important;
    width: 20px;
    height: 20px;
    object-fit: cover;
  }
`;

const Container = styled.div`
  display: flex;
  .HeaderIcon {
    margin-right: 3px;
  }
`;

const IssueNumBtn = styled.button`
  cursor: pointer;
  font-size: 14px;
  font-weight: bold;
  background-color: Transparent;
  border: none;
  outline: none;
`;

const issueListHeader = () => {
  const { openIssues, closeIssues, setIssues } = useContext(IssueContext);
  const { users } = useContext(UserContext);

  const changeIssue = async (event, status) => {
    let response = null;
    let result = null;

    switch (status) {
      case 'CHANGE_STATUS_OPEN':
        response = await fetch(GET_OPEN_ISSUE, getOptions());
        result = await response.json();
        setIssues(result.data);
        break;

      case 'CHANGE_STATUS_CLOSED':
        response = await fetch(GET_CLOSED_ISSUE, getOptions());
        result = await response.json();
        setIssues(result.data);
        break;

      default:
        break;
    }
  };

  const clickHandler = (e, className) => {
    const item = e.target.closest('.dropdown');
    const menu = item.querySelector('.dropdown-menu');
    menu.classList.toggle('visible');
    console.log(menu);
  };

  return (
    <HeaderContainer>
      <Container>
        <input type="checkbox" className="allIssue" />
        <IssueNumBtn
          onClick={(e) => {
            changeIssue(e, 'CHANGE_STATUS_OPEN');
          }}
        >
          <IssueOpenedIcon className="HeaderIcon" size={16} />
          {openIssues.length} Open{' '}
        </IssueNumBtn>

        <IssueNumBtn
          onClick={(e) => {
            changeIssue(e, 'CHANGE_STATUS_CLOSED');
          }}
        >
          <CheckIcon size={16} className="HeaderIcon" />
          {closeIssues.length} Closed{' '}
        </IssueNumBtn>
      </Container>
      <FilterList>
        <DropdownContainer>
          <Dropdown
            className="author-dropdown dropdown"
            text="Author"
            onClick={(e) => {
              clickHandler(e, '.author-dropdown-menu');
            }}
          >
            <Dropdown.Menu
              className="author-dropdown-menu dropdown-menu"
              direction="left"
              // style={{ display: 'none' }}
            >
              <Dropdown.Header
                className="dropdown-header"
                content="Filter by author"
              />
              {users &&
                users.map((item, index) => (
                  <div key={item.id} value={index}>
                    <hr className="dropdown-divider" />
                    <Dropdown.Item className="dropdown-item">
                      <ItemContainer>
                        <CheckIcon size={16} className="check-icon" />
                        <img src={item.imageUrl} />
                        <div>{item.name}</div>
                      </ItemContainer>
                    </Dropdown.Item>
                  </div>
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
