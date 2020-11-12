import React, { useReducer, useEffect } from 'react';
import useFetch from '../hooks/useFetch';
import { GET_LABELS } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { labelReducer, newReducer } from '../reducers/labelReducer';

export const LabelContext = React.createContext();

const LabelStore = (props) => {
  const [labels, labelDispatch] = useReducer(labelReducer, []);
  const [isClickNew, newDispatch] = useReducer(newReducer, false);

  const setIntiData = (initData) => {
    labelDispatch({ type: 'SET_INIT_DATA', payload: initData });
  };

  const loading = useFetch(setIntiData, GET_LABELS, getOptions());

  return (
    <LabelContext.Provider
      value={{ labels, loading, labelDispatch, isClickNew, newDispatch }}
    >
      {props.children}
    </LabelContext.Provider>
  );
};

export default LabelStore;
