import React, { useContext, useState } from 'react';
import styled, { css } from 'styled-components';

import { CommentContext } from '../../stores/CommentStore';
import getDiffTime from '../../utils/getDiffTime';

const Discussion = styled.div`
  display: flex;
  margin-top: 55px;
`;

const AuthorImage = styled.img`
  border-radius: 50%;
  width: 40px;
  height: 40px;
`;

const DiscussionContent = styled.div`
  margin-left: 20px;
  width: 832px;
`;

const CommentTimeline = styled.div`
  display: flex;
  background-color: #f6f8fa;
  align-items: center;
  border: 1px solid rgba(3, 102, 214, 0.2);
  border-radius: 5px;
  padding: 0 16px;
  border-bottom: 0px;
  border-bottom-right-radius: 0px;
  border-bottom-left-radius: 0px;
`;

const CommentAuthor = styled.p`
  margin-right: 5px;
  font-weight: bold;
  font-size: 14px;
`;

const CommentedTime = styled.p`
  font-size: 14px;
  color: #586069;
`;

const Emoticon = styled.img`
  width: 16px;
  height: 16px;
  margin-right: 8px;
  margin-left: auto;
`;

const Comment = styled.div`
  border: 1px solid rgba(3, 102, 214, 0.2);
  border-radius: 5px;
  border-top-left-radius: 0px;
  border-top-right-radius: 0px;
  padding: 15px;
`;

const CommentContainer = ({ userId, name, content, imageUrl, createAt }) => {
  // const [isOpenTab, setIsOpenTab] = useState(false);

  const { commentDispatch } = useContext(CommentContext);
  // const deleteLabelRequest = () => {
  //   const options = deleteOptions();
  //   fetch(DELETE_LABELS(id), options);
  // };

  // const openEditTab = (e) => {
  //   setIsOpenTab(true);
  // };

  // const deleteLabel = (e) => {
  //   if (confirm(`${name}을 정말로 삭제하시겠습니까?`)) {
  //     deleteLabelRequest();
  //     labelDispatch({ type: 'DELETE_LABEL', payload: id });
  //   }
  // };

  // const EditForm = (
  //   <>
  //     <LabelForm
  //       type="EDIT"
  //       initName={name}
  //       initDescription={description}
  //       initColor={color}
  //       background="white"
  //       label_id={id}
  //       callback={setIsOpenTab}
  //     >
  //       <Button onClick={deleteLabel}>
  //         <Text>Delete</Text>
  //       </Button>
  //     </LabelForm>
  //   </>
  // );

  const CommentInfo = (
    <Discussion>
      <AuthorImage src={`${imageUrl}`} />
      <DiscussionContent>
        <CommentTimeline>
          <CommentAuthor>{name}</CommentAuthor>
          <CommentedTime>commented {getDiffTime(createAt)} ago</CommentedTime>
          <Emoticon src="/images/emoticon.svg"></Emoticon>
        </CommentTimeline>
        <Comment>
          <p>{content}</p>
        </Comment>
      </DiscussionContent>
    </Discussion>
  );

  return <>{CommentInfo}</>;
};

export default CommentContainer;
