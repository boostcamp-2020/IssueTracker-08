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
        font-weight: bold;
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

export default function FilterDropdown({
  markAsOpenHandler,
  markAsCloseHandler,
}) {
  return (
    <DropdownContainer>
      <Dropdown className="dropdown" text="Mark as">
        <Dropdown.Menu className="dropdown-menu" direction="left">
          <Dropdown.Header className="dropdown-header" content="Actions" />
          <hr className="dropdown-divider" />
          <Dropdown.Item
            className="dropdown-item"
            text="Open 🤗"
            onClick={markAsOpenHandler}
          />
          <hr className="dropdown-divider" />
          <Dropdown.Item
            className="dropdown-item"
            text="Closed 😥"
            onClick={markAsCloseHandler}
          />
        </Dropdown.Menu>
      </Dropdown>
    </DropdownContainer>
  );
}
