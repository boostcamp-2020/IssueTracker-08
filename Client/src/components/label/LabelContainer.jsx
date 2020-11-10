import React from 'react';
import styled from 'styled-components';
import Label from './Label';

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

const LabelContainer = (props) => {
  return (
    <Container>
      <FlexContainer flex="1">
        <Label name={props.name} color={props.color} />
      </FlexContainer>
      <FlexContainer flex="3">
        <Text>{props.description}</Text>
      </FlexContainer>
      <Button>
        <Text>Edit</Text>
      </Button>
      <Button>
        <Text>Delete</Text>
      </Button>
    </Container>
  );
};

export default LabelContainer;
