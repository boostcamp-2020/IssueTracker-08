import React, { useContext, useState } from 'react';
import styled from 'styled-components';
import { Dropdown } from 'semantic-ui-react';
import { CheckIcon } from '@primer/octicons-react';
import { IssueOpenedIcon } from '@primer/octicons-react';

import { IssueContext } from '../../../stores/IssueStore';
import { UserContext } from '../../../stores/UserStore';
import { LabelContext } from '../../../stores/LabelStore';
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
    cursor: pointer;
    .dropdown-menu {
      display: none;
      font-size: 17px;
      background: #f7f8fa;
      border: 1px solid #ebecef;
      .item:hover {
        background: #f7f8fa;
      }
      .dropdown-item {
        padding: 8px;
        font-weight: 500;
        font-size: 13.5px;
        background: white;
      }
    }
    .visible {
      display: inline-block !important;
    }

    .dropdown-header {
      font-size: 12px;
      display: flex;
      padding: 7px 7px 7px 16px;
      align-items: center;
      border-bottom: 1px solid var(--color-select-menu-border-secondary);
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
    margin-left: 10px;
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

const LabelColor = styled.div`
  margin-left: 10px;
  margin-right: 8px;
  border-radius: 50% !important;
  width: 20px;
  height: 20px;
  object-fit: cover;
`;

const FlexContainer = styled.div`
  display: flex;
  flex-direction: column;
`;

const FlexItem = styled.div`
  flex: 1;
  overflow: auto;
`;

const issueListHeader = () => {
  const {
    openIssues,
    closeIssues,
    setIssues,
    milestones,
    dispatchIssues,
  } = useContext(IssueContext);
  const { users } = useContext(UserContext);
  const { labels } = useContext(LabelContext);
  const [issueStatus, setIssueStatus] = useState('open');

  const changeIssue = async (event, status) => {
    let response = null;
    let result = null;

    switch (status) {
      case 'CHANGE_STATUS_OPEN':
        setIssueStatus('open');
        response = await fetch(GET_OPEN_ISSUE, getOptions());
        result = await response.json();
        setIssues(result.data);
        break;

      case 'CHANGE_STATUS_CLOSED':
        setIssueStatus('closed');
        response = await fetch(GET_CLOSED_ISSUE, getOptions());
        result = await response.json();
        setIssues(result.data);
        break;

      default:
        break;
    }
  };

  const clickHandler = (e) => {
    const item = e.target.closest('.dropdown');
    const menu = item.querySelector('.dropdown-menu');
    menu.classList.toggle('visible');
  };

  const filterHandler = async (e, type, payload = null) => {
    try {
      if (issueStatus === 'open') await changeIssue(e, 'CHANGE_STATUS_OPEN');
      else await changeIssue(e, 'CHANGE_STATUS_CLOSED');

      switch (type) {
        case 'ALL':
          break;

        default:
          dispatchIssues({ type, payload });
          break;
      }
    } catch (error) {
      console.log(error);
    }
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
            className="dropdown"
            text="Author"
            onClick={(e) => {
              clickHandler(e);
            }}
          >
            <Dropdown.Menu className="dropdown-menu">
              <Dropdown.Header
                className="dropdown-header"
                content="Filter by author"
                onClick={(e) => {
                  filterHandler(e, 'ALL');
                }}
              />
              {users &&
                users.map((item) => (
                  <div
                    key={item.id}
                    onClick={(e) => {
                      filterHandler(e, 'FILTER_AUTHOR', item.id);
                    }}
                  >
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
          <Dropdown
            text="Label"
            onClick={(e) => {
              clickHandler(e);
            }}
          >
            <Dropdown.Menu className="dropdown-menu">
              <Dropdown.Header
                className="dropdown-header"
                content="Filter by label"
                onClick={(e) => {
                  filterHandler(e, 'ALL');
                }}
              />
              {labels &&
                labels.map((item) => (
                  <div
                    key={item.id}
                    onClick={(e) => {
                      filterHandler(e, 'FILTER_LABEL', item.name);
                    }}
                  >
                    <hr className="dropdown-divider" />
                    <Dropdown.Item className="dropdown-item">
                      <ItemContainer>
                        <LabelColor style={{ background: item.color }} />
                        <FlexContainer>
                          <FlexItem>{item.name} </FlexItem>
                          <div style={{ color: '#586069' }}>
                            {' '}
                            <FlexItem>{item.description} </FlexItem>
                          </div>
                        </FlexContainer>
                      </ItemContainer>
                    </Dropdown.Item>
                  </div>
                ))}
            </Dropdown.Menu>
          </Dropdown>
        </DropdownContainer>

        <DropdownContainer>
          <Dropdown text="Milestones">
            <Dropdown.Menu className="dropdown-menu">
              <Dropdown.Header
                className="dropdown-header"
                content="Filter by milestones"
                onClick={(e) => {
                  filterHandler(e, 'ALL');
                }}
              />
              {milestones &&
                milestones.map((item) => (
                  <div
                    key={item.id}
                    onClick={(e) => {
                      filterHandler(e, 'FILTER_MILESTONE', item.title);
                    }}
                  >
                    <hr className="dropdown-divider" />
                    <Dropdown.Item className="dropdown-item">
                      <FlexContainer>
                        <FlexItem>{item.title} </FlexItem>
                        <div style={{ color: '#586069' }}>
                          {' '}
                          <FlexItem>{item.content} </FlexItem>
                        </div>
                      </FlexContainer>
                    </Dropdown.Item>
                  </div>
                ))}
            </Dropdown.Menu>
          </Dropdown>
        </DropdownContainer>

        <DropdownContainer>
          <Dropdown text="Assignee">
            <Dropdown.Menu className="dropdown-menu">
              <Dropdown.Header
                className="dropdown-header"
                content="Filter by who's assigned"
                onClick={(e) => {
                  filterHandler(e, 'ALL');
                }}
              />
              {users &&
                users.map((item) => (
                  <div key={item.id}>
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
      </FilterList>
    </HeaderContainer>
  );
};

export default issueListHeader;
