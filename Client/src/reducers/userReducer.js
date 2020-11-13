export const userReducer = (issues, { type, payload }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      return payload;
    default:
      break;
  }
};
