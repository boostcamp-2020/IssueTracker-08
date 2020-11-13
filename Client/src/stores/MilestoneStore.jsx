import React, { useReducer, useEffect, useState } from 'react';
import useFetch from '../hooks/useFetch';
import { GET_MILESTONES } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { milestoneReducer } from '../reducers/milestoneReducer';

export const MilestoneContext = React.createContext();

const MilestoneStore = (props) => {
  const [milestones, milestoneDispatch] = useReducer(milestoneReducer, []);
  const [isOpenClicked, setIsOpenClicked] = useState(1);
  const [open, setOpen] = useState(0);
  const [closed, setClosed] = useState(0);

  const updateMilestone = (payload) => {
    let open = 0;
    let closed = 0;
    payload.forEach((milestone) => {
      if (milestone.isOpen) {
        open += 1;
      } else {
        closed += 1;
      }
    });
    setOpen(open);
    setClosed(closed);
  };

  const setIntiData = (initData) => {
    milestoneDispatch({
      type: 'SET_INIT_DATA',
      payload: initData,
      update: updateMilestone,
    });
  };

  const loading = useFetch(setIntiData, GET_MILESTONES, getOptions());

  return (
    <MilestoneContext.Provider
      value={{
        milestones,
        loading,
        isOpenClicked,
        setIsOpenClicked,
        open,
        closed,
        milestoneDispatch,
        updateMilestone,
      }}
    >
      {props.children}
    </MilestoneContext.Provider>
  );
};

export default MilestoneStore;
