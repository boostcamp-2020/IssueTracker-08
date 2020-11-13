import React, { useEffect, useState } from 'react';
import styled from 'styled-components';

const IssueEdit = styled.button`
  margin-left: auto;
  height: 30px;
  padding: 3px 12px;
  font-size: 12px;
  background-color: #fafbfc;
  &:hover {
    background-color: #e1e4e8;
  }
  border: 1px solid #e8e9ec;
  border-radius: 6px;
  cursor: pointer;
`;

const EditButton = ({ visible }) => {
  if (visible) {
    return <IssueEdit>Edit</IssueEdit>;
  }
  return <></>;
};

export default EditButton;
