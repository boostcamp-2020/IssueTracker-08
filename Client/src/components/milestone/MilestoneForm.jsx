import React, { useContext } from 'react';
import { Link } from 'react-router-dom';
import styled from 'styled-components';

const Container = styled.div`
  display: flex;
  flex-direction: column;
  border-top: 1px solid #c3c3c3;
  border-bottom: 1px solid #c3c3c3;
  margin-bottom: 20px;
  padding: 20px 0px;
`;

const InputTitle = styled.p`
  font-size: 12px;
  font-weight: bold;
  margin: 4px 0px;
`;

const Input = styled.input`
  width: 500px;
  height: 24px;
  background: #f5f5f5;
  border-radius: 3px;
  border: 1px solid #bbbbbb;
  padding-left: 10px;
  margin-bottom: 10px;
`;

const TextArea = styled.textarea`
  width: 700px;
  height: 220px;
  background: #f5f5f5;
  border-radius: 3px;
  border: 1px solid #bbbbbb;
  padding-left: 10px;
  margin-bottom: 10px;
`;

const ActionMenu = styled.div`
  display: flex;
  justify-content: flex-end;
`;

const Button = styled.button`
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
  margin-left: 20px;
`;

const MilestoneForm = ({ link, submit, children }) => {
  return (
    <>
      <Container>
        <InputTitle>Title</InputTitle>
        <Input placeholder="Title" />
        <InputTitle>Due date (optional)</InputTitle>
        <Input type="date" placeholder="연도. 월. 일." />
        <InputTitle>Description (optional)</InputTitle>
        <TextArea />
      </Container>
      <ActionMenu>
        {children}
        <Link to={link}>
          <Button>{submit}</Button>
        </Link>
      </ActionMenu>
    </>
  );
};

export default MilestoneForm;
