import React, { useContext } from 'react';
import LabelContainer from './LabelContainer';
import { LabelContext } from '../../stores/LabelStore';

const LabelList = () => {
  const { labels, loading } = useContext(LabelContext);
  let labelList = <div>Loading...</div>;
  if (!loading) {
    labelList = labels.map((label) => (
      <LabelContainer
        key={label.id}
        id={label.id}
        name={label.name}
        color={label.color}
        description={label.description}
      />
    ));
  }
  return <>{labelList}</>;
};

export default LabelList;
