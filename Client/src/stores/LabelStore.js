import React, { useReducer, useEffect } from 'react';
import useFetch from '../hooks/useFetch';
import { GET_LABELS } from '../utils/api';
import { getOptions } from '../utils/fetchOptions';
import { labelReducer } from '../reducers/labelReducer';

export const LabelContext = React.createContext();

const LabelStore = (props) => {
  const [labels, dispatch] = useReducer(labelReducer, []);

  const setIntiData = (initData) => {
    dispatch({ type: 'SET_INIT_DATA', payload: initData });
  };

  const loading = useFetch(setIntiData, GET_LABELS, getOptions());

  return (
    <LabelContext.Provider value={{ labels, loading, dispatch }}>
      {props.children}
    </LabelContext.Provider>
  );
};

export default LabelStore;
