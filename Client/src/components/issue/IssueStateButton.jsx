import React from 'react';
import styled from 'styled-components';

const StateButton = styled.button`
  color: white;
  border-radius: 2em;
  border-color: transparent;
  margin-right: 8px;
  padding: 5px 12px;
  height: 35px;
  display: flex;
  align-items: center;
  background-color: ${(props) => (props.open ? '#28a745' : '#d73a49')};
`;

const ExclamIcon = styled.img`
  width: 15px;
  margin-right: 4px;
`;

const CloseIcon = styled.img`
  width: 15px;
  margin-right: 4px;
`;

const State = styled.p`
  font-size: 14px;
  font-weight: bold;
`;

function IssueStateButton({ state }) {
  if (state) {
    return (
      <StateButton open>
        <ExclamIcon src="/images/exclam_circle.svg" />
        <State>Open</State>
      </StateButton>
    );
  } else {
    return (
      <StateButton closed>
        <CloseIcon src="/images/close.svg" />
        <State>Closed</State>
      </StateButton>
    );
  }
}

export default IssueStateButton;
