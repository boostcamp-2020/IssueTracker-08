import React, { useContext, useState } from 'react';
import styled from 'styled-components';

import { IssueContext } from '../../../stores/IssueStore';
import { UserContext } from '../../../stores/UserStore';
import { LabelContext } from '../../../stores/LabelStore';
import { GET_OPEN_ISSUE, GET_CLOSED_ISSUE } from '../../../utils/api';
import { getOptions } from '../../../utils/fetchOptions';

import OpenHeaderBtn from './button/openHeaderBtn';
import ClosedHeaderBtn from './button/closedHeaderBtn';

import AuthorDropdown from './button/authorDropdown';
import LabelDropdown from './button/labelDropdown';
import MilestoneDropdown from './button/milestoneDropdown';
import AssigneeDropdown from './button/assigneeDropdown';

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

const Container = styled.div`
  display: flex;
  .HeaderIcon {
    margin-right: 3px;
  }
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
        <OpenHeaderBtn
          issueStatus={issueStatus}
          openIssues={openIssues}
          changeIssue={changeIssue}
        />
        <ClosedHeaderBtn
          issueStatus={issueStatus}
          closeIssues={closeIssues}
          changeIssue={changeIssue}
        />
      </Container>

      <FilterList>
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
      </FilterList>
    </HeaderContainer>
  );
};

export default issueListHeader;
