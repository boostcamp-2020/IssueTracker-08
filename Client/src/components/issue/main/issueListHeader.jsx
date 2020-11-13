import React, { useContext, useState } from 'react';
import styled from 'styled-components';

import { IssueContext } from '../../../stores/IssueStore';
import { UserContext } from '../../../stores/UserStore';
import { LabelContext } from '../../../stores/LabelStore';
import {
  GET_OPEN_ISSUE,
  GET_CLOSED_ISSUE,
  CLOSE_ISSUE,
  OPEN_ISSUE,
} from '../../../utils/api';
import { getOptions, postOptions } from '../../../utils/fetchOptions';

import OpenHeaderBtn from './button/openHeaderBtn';
import ClosedHeaderBtn from './button/closedHeaderBtn';

import AuthorDropdown from './button/authorDropdown';
import LabelDropdown from './button/labelDropdown';
import MilestoneDropdown from './button/milestoneDropdown';
import AssigneeDropdown from './button/assigneeDropdown';
import FilterDropdown from './button/filterDropdown';

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

  .checked-item-count {
    margin-left: 10px;
    font-size: 15px;
    background-color: Transparent;
    border: none;
    outline: none;
    color: #586069;
  }
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

const Container = styled.div`
  display: flex;
  .HeaderIcon {
    margin-right: 3px;
  }
`;

const issueListHeader = () => {
  const {
    issues,
    openIssues,
    closeIssues,
    checkItems,
    setIssues,
    milestones,
    dispatchIssues,
    setCheckItem,
  } = useContext(IssueContext);

  const { users } = useContext(UserContext);
  const { labels } = useContext(LabelContext);

  const [issueStatus, setIssueStatus] = useState('open');

  const changeIssue = async (status) => {
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
      if (issueStatus === 'open') await changeIssue('CHANGE_STATUS_OPEN');
      else await changeIssue('CHANGE_STATUS_CLOSED');

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

  const checkHandler = (checked) => {
    if (checked) {
      setCheckItem({ type: 'SELECT_ALL', data: issues });
    } else {
      setCheckItem({ type: 'DESELECT_ALL', data: new Set() });
    }
  };

  const markAsOpenHandler = async () => {
    alert(
      `선택하신 ${checkItems.checkedItems.length}개의 이슈를 open 합니다! 🤗`
    );

    try {
      checkItems.checkedItems.forEach(async (issue) => {
        await fetch(OPEN_ISSUE(issue.issueId), postOptions());
      });

      if (issueStatus === 'open') await changeIssue('CHANGE_STATUS_OPEN');
      else await changeIssue('CHANGE_STATUS_CLOSED');

      window.location.reload(false);
    } catch (error) {
      console.log(error);
    }
  };

  const markAsCloseHandler = async () => {
    alert(
      `선택하신 ${checkItems.checkedItems.length}개의 이슈를 close 합니다! 😥`
    );

    try {
      checkItems.checkedItems.forEach(async (issue) => {
        await fetch(CLOSE_ISSUE(issue.issueId), postOptions());
      });

      if (issueStatus === 'open') await changeIssue('CHANGE_STATUS_OPEN');
      else await changeIssue('CHANGE_STATUS_CLOSED');

      window.location.reload(false);
    } catch (error) {
      console.log(error);
    }
  };

  return (
    <HeaderContainer>
      <Container>
        <input
          type="checkbox"
          className="allIssue"
          onChange={(e) => checkHandler(e.target.checked)}
        />

        <OpenHeaderBtn
          className="open-button"
          issueStatus={issueStatus}
          openIssues={openIssues}
          changeIssue={changeIssue}
          checkItems={checkItems}
        />
        <ClosedHeaderBtn
          className="closed-button"
          issueStatus={issueStatus}
          closeIssues={closeIssues}
          changeIssue={changeIssue}
          checkItems={checkItems}
        />

        {checkItems.isAllChecked === false ? null : (
          <div className="checked-item-count">
            {checkItems.checkedItems.length} selected
          </div>
        )}
      </Container>

      <FilterList>
        {checkItems.isAllChecked === false ? (
          <>
            <AuthorDropdown
              users={users}
              clickHandler={clickHandler}
              filterHandler={filterHandler}
            />
            <LabelDropdown
              labels={labels}
              clickHandler={clickHandler}
              filterHandler={filterHandler}
            />
            <MilestoneDropdown
              milestones={milestones}
              clickHandler={clickHandler}
              filterHandler={filterHandler}
            />
            <AssigneeDropdown
              users={users}
              clickHandler={clickHandler}
              filterHandler={filterHandler}
            />
          </>
        ) : (
          <FilterDropdown
            markAsOpenHandler={markAsOpenHandler}
            markAsCloseHandler={markAsCloseHandler}
          />
        )}
      </FilterList>
    </HeaderContainer>
  );
};

export default issueListHeader;
