export const milestoneReducer = (milestones, { type, payload }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      return payload;

    default:
      break;
  }
};
