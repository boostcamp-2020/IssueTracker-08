export const checkReducer = (state, action) => {
  switch (action.type) {
    case 'SELECT_ALL':
      return {
        ...state,
        isAllChecked: true,
        checkedItems: action.data,
      };

    case 'DESELECT_ALL':
      return {
        ...state,
        isAllChecked: false,
        checkedItems: new Set(),
      };

    default:
      return state;
  }
};
