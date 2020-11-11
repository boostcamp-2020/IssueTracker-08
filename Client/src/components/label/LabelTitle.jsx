import React, { useContext } from 'react';
import Title from '../shared/text/Title';
import { LabelContext } from '../../stores/LabelStore';

const LabelTitle = () => {
  const { labels } = useContext(LabelContext);
  return (
    <>
      <Title text={labels.length + ' labels'} />
    </>
  );
};

export default LabelTitle;
