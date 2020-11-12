export const milestoneReducer = (milestones, { type, payload, update }) => {
  let result;

  switch (type) {
    case 'SET_INIT_DATA':
      update(payload);
      return payload;

    case 'CLOSED_MILESTONE':
      result = milestones.map((milestone) => {
        if (milestone.id === payload) {
          milestone.isOpen = 0;
        }

        return milestone;
      });
      update(result);
      return result;

    case 'REOPEN_MILESTONE':
      result = milestones.map((milestone) => {
        if (milestone.id === payload) {
          milestone.isOpen = 1;
        }

        return milestone;
      });
      update(result);
      return result;

    case 'DELETE_MILESTONE':
      result = milestones.filter((milestone) => milestone.id !== payload);
      update(result);
      return result;

    default:
      break;
  }
};
