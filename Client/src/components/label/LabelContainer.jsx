import React, { useContext, useState } from 'react';
import styled, { css } from 'styled-components';
import Label from './Label';

import { LabelContext } from '../../stores/LabelStore';
import { DELETE_LABELS } from '../../utils/api';
import { deleteOptions } from '../../utils/fetchOptions';
import LabelForm from './LabelForm';

const Container = styled.div`
  display: flex;
  align-items: center;
  height: 40px;
  border: 1px solid #ebecef;
  background: white;
  padding: 10px;
  ${(props) =>
    props.borderTop &&
    css`
      border-top: 1px;
    `};
  ${(props) =>
    props.borderBottom &&
    css`
      border-bottom: 1px;
    `};
`;

const FlexContainer = styled.div`
  flex: ${(props) => props.flex};
`;

const Button = styled.button`
  min-width: 60px;
  background: transparent;
  border: 0px;
`;

const Text = styled.p`
  color: #91979d;
`;

const LabelContainer = ({ id, name, color, description }) => {
  const [isOpenTab, setIsOpenTab] = useState(false);

  const { labelDispatch } = useContext(LabelContext);
  const deleteLabelRequest = () => {
    const options = deleteOptions();
    fetch(DELETE_LABELS(id), options);
  };

  const openEditTab = (e) => {
    setIsOpenTab(true);
  };

  const deleteLabel = (e) => {
    if (confirm(`${name}을 정말로 삭제하시겠습니까?`)) {
      deleteLabelRequest();
      labelDispatch({ type: 'DELETE_LABEL', payload: id });
    }
  };

  const EditForm = (
    <>
      <LabelForm
        type="EDIT"
        initName={name}
        initDescription={description}
        initColor={color}
        background="white"
        callback={setIsOpenTab}
      >
        <Button onClick={deleteLabel}>
          <Text>Delete</Text>
        </Button>
      </LabelForm>
    </>
  );

  const LabelInfo = (
    <Container>
      <FlexContainer flex="1">
        <Label name={name} color={color} />
      </FlexContainer>
      <FlexContainer flex="3">
        <Text>{description}</Text>
      </FlexContainer>
      <Button>
        <Text onClick={openEditTab}>Edit</Text>
      </Button>
      <Button onClick={deleteLabel}>
        <Text>Delete</Text>
      </Button>
    </Container>
  );

  return <>{isOpenTab ? EditForm : LabelInfo}</>;
};

export default LabelContainer;
