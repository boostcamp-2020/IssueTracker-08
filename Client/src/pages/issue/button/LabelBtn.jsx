import React, { useContext } from 'react';
import { TagIcon } from '@primer/octicons-react';
import { useHistory } from 'react-router-dom';
import styled from 'styled-components';

import { LabelContext } from '../../../stores/LabelStore';

const ButtonDesign = styled.button`
  display: flex;
  box-sizing: border-box;
  min-width: 80px;
  border: 1px solid #dcdcdc;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 600;
  padding: 0px 13px;
  cursor: pointer;
  outline: none;
`;

const LabelButton = styled(ButtonDesign)`
  border-radius: 4px 0 0 4px;
  background: #ffffff;
  color: #606060;
  border-right: 1px solid #e0e0e0;
`;

const ButtonText = styled.p`
  margin: 0 5px;
`;

const ShowTotalNum = styled.span`
  padding: 3px 6px;
  background: #f2f2f2;
  border-radius: 50px;
`;

export default function LabelBtn() {
  const history = useHistory();
  const { labels } = useContext(LabelContext);

  return (
    <LabelButton onClick={() => history.push('/label')}>
      <TagIcon size={14} />
      <ButtonText>Labels</ButtonText>
      <ShowTotalNum>{labels ? labels.length : 0}</ShowTotalNum>
    </LabelButton>
  );
}
