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

export default function LabelDropdown({ labels, clickHandler, filterHandler }) {
  return (
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
  );
}
