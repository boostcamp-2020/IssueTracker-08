import React, { useReducer, useEffect } from 'react';
import useFetch from '../hooks/useFetch';
import { GET_MILESTONES } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { milestoneReducer } from '../reducers/milestoneReducer';

export const MilestoneContext = React.createContext();

const MilestoneStore = (props) => {
  const [milestones, milestoneDispatch] = useReducer(milestoneReducer, []);

  const setIntiData = (initData) => {
    milestoneDispatch({ type: 'SET_INIT_DATA', payload: initData });
  };

  const loading = useFetch(setIntiData, GET_MILESTONES, getOptions());

  return (
    <MilestoneContext.Provider
      value={{ milestones, loading, milestoneDispatch }}
    >
      {props.children}
    </MilestoneContext.Provider>
  );
};

export default MilestoneStore;
