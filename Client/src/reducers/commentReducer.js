export const commentReducer = (comments, { type, payload }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      return payload;

    case 'NEW_COMMENT_ADD':
      return [...comments, payload];

    default:
      break;
  }
};
