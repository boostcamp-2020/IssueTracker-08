export const milestoneReducer = (milestones, { type, payload, update }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      update(payload);
      return payload;

    default:
      break;
  }
};
