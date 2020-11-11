import React, { useContext } from 'react';
import styled from 'styled-components';
import { LabelContext } from '../../stores/LabelStore';
import Menu from '../shared/container/Menu';
import LabelForm from './LabelForm';

const NewButton = styled.button`
  min-width: 120px;
  box-shadow: 0px 1px 0px 0px #3dc21b;
  background: linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%);
  background-color: #44c767;
  border-radius: 6px;
  border: 1px solid #18ab29;
  display: inline-block;
  cursor: pointer;
  color: white;
  font-size: 15px;
  font-weight: bold;
  padding: 10px;
  text-decoration: none;
  text-shadow: 0px -1px 0px #2f6627;
  margin-left: auto;
`;

const LabelMenu = () => {
  const { isClickNew, newDispatch } = useContext(LabelContext);

  const openNewLabelTab = (e) => {
    newDispatch({ type: 'NEW_LABEL_TAB_OPEN' });
  };

  return (
    <>
      <Menu name="label" link="/label">
        <NewButton onClick={openNewLabelTab}>New Label</NewButton>
      </Menu>
      {isClickNew ? (
        <LabelForm type="NEW" initName="" initDescription="" />
      ) : (
        <></>
      )}
    </>
  );
};

export default LabelMenu;
