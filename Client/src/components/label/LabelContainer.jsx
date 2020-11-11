import React, { useContext } from 'react';
import styled from 'styled-components';
import Label from './Label';

import { LabelContext } from '../../stores/LabelStore';
import { DELETE_LABELS } from '../../utils/api';
import { deleteOptions } from '../../utils/fetchOptions';

const Container = styled.div`
  display: flex;
  align-items: center;
  height: 40px;
  border: 1px solid #ebecef;
  background: white;
  padding: 10px;
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
  const { dispatch } = useContext(LabelContext);
  const deleteLabelRequest = () => {
    const options = deleteOptions();
    fetch(DELETE_LABELS(id), options);
  };

  const deleteLabel = (e) => {
    if (confirm(`${name}을 정말로 삭제하시겠습니까?`)) {
      deleteLabelRequest();
      dispatch({ type: 'DELETE_LABEL', payload: id });
    }
  };
  return (
    <Container>
      <FlexContainer flex="1">
        <Label name={name} color={color} />
      </FlexContainer>
      <FlexContainer flex="3">
        <Text>{description}</Text>
      </FlexContainer>
      <Button>
        <Text>Edit</Text>
      </Button>
      <Button onClick={deleteLabel}>
        <Text>Delete</Text>
      </Button>
    </Container>
  );
};

export default LabelContainer;
