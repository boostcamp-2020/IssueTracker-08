export const issueDetailReducer = (issueDetail, { type, payload }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      return payload[0];

    case 'CLOSE_ISSUE':
      return { ...issueDetail, isOpen: 0 };

    case 'OPEN_ISSUE':
      return { ...issueDetail, isOpen: 1 };

    default:
      break;
  }
};
