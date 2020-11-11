export const labelReducer = (labels, { type, payload }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      return payload;

    case 'DELETE_LABEL':
      return labels.filter((label) => label.id !== payload);

    default:
      break;
  }
};
