export const issueReducer = (issues, { type, payload }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      return payload;

    case 'FILTER_AUTHOR':
      return issues.filter((issue) => issue.userId === payload);

    default:
      break;
  }
};
