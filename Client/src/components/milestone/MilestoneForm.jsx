import React, { useState, useRef, useEffect } from 'react';
import { useHistory } from 'react-router-dom';
import styled, { css } from 'styled-components';
import { GET_MILESTONE, POST_MILESTONE } from '../../utils/api';
import { getOptions, postOptions } from '../../utils/fetchOptions';
import { getFormatDate } from '../../utils/time';

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

const Submit = styled.button`
  min-width: 120px;
  box-shadow: 0px 1px 0px 0px #3dc21b;
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
  ${(props) =>
    props.isValid
      ? css`
          background: linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%);
          background-color: #44c767;
        `
      : css`
          background: linear-gradient(to bottom, #77b55a 5%, #72b352 100%);
          background-color: #77b55a;
          color: #dedede;
          pointer-events: none;
        `};
`;

const initActiveState = (type) => {
  if (type === 'NEW') {
    return false;
  }
  return true;
};

const MilestoneForm = ({ type, id, submit, children }) => {
  const history = useHistory();
  const titleRef = useRef(false);
  const dateRef = useRef(false);
  const descriptionRef = useRef(false);
  const [title, setTitle] = useState('');
  const [date, setDate] = useState('');
  const [description, setDescription] = useState('');
  const [isActive, setIsActive] = useState(initActiveState(type));

  const titleInputChange = (e) => {
    setIsActive(true);
    const currentValue = titleRef.current.value;
    if (currentValue === '') {
      setIsActive(false);
    }
    setTitle(currentValue);
  };

  const dateInputChange = (e) => {
    setDate(dateRef.current.value);
  };

  const descriptionInputChange = (e) => {
    setDescription(descriptionRef.current.value);
  };

  const submitForm = async (e) => {
    const title = titleRef.current.value;
    let date = dateRef.current.value;
    let description = descriptionRef.current.value;

    if (date === '') {
      date = null;
    }

    if (description === '') {
      description = null;
    }

    const milestone = {
      title: title,
      dueDate: date,
      content: description,
    };

    if (type === 'NEW') {
      const options = postOptions(milestone);
      await fetch(POST_MILESTONE, options);
    }

    history.push('/milestone');
  };

  const getMilestoneInfo = async () => {
    const response = await fetch(GET_MILESTONE(id), getOptions());
    const responseJSON = await response.json();
    const milestone = responseJSON.data[0];
    const dueDate = getFormatDate(milestone.dueDate);
    setTitle(milestone.title);
    setDate(dueDate);
    setDescription(milestone.content);
  };

  useEffect(() => {
    if (type === 'EDIT') {
      getMilestoneInfo();
    }
  }, []);

  return (
    <>
      <Container>
        <InputTitle>Title</InputTitle>
        <Input
          placeholder="Title"
          ref={titleRef}
          onChange={titleInputChange}
          value={title}
        />
        <InputTitle>Due date (optional)</InputTitle>
        <Input
          type="date"
          placeholder="연도. 월. 일."
          ref={dateRef}
          onChange={dateInputChange}
          value={date}
        />
        <InputTitle>Description (optional)</InputTitle>
        <TextArea
          ref={descriptionRef}
          onChange={descriptionInputChange}
          value={description}
        />
      </Container>
      <ActionMenu>
        {children}
        <Submit isValid={isActive} onClick={submitForm}>
          {submit}
        </Submit>
      </ActionMenu>
    </>
  );
};

export default MilestoneForm;
