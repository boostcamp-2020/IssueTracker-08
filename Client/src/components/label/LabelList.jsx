import React from 'react';
import styled from 'styled-components';
import LabelContainer from './LabelContainer';

const LabelList = ({ labels, loading }) => {
  let labelList = <div>Loading...</div>;
  if (!loading) {
    labelList = labels.map((label) => (
      <LabelContainer
        key={label.id}
        name={label.name}
        color={label.color}
        description={label.description}
      />
    ));
  }
  return <>{labelList}</>;
};

export default LabelList;
