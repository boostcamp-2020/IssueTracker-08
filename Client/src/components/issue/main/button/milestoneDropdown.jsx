import React from 'react';
import styled from 'styled-components';
import { Dropdown } from 'semantic-ui-react';

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

const FlexContainer = styled.div`
  display: flex;
  flex-direction: column;
`;

const FlexItem = styled.div`
  flex: 1;
  overflow: auto;
`;

export default function MilestoneDropdown({
  milestones,
  clickHandler,
  filterHandler,
}) {
  return (
    <DropdownContainer>
      <Dropdown
        text="Milestones"
        onClick={(e) => {
          clickHandler(e);
        }}
      >
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
  );
}
