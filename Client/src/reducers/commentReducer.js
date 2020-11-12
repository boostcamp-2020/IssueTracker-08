export const commentReducer = (comments, { type, payload }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      return payload;

    //   case 'PUT_LABEL':
    //     return labels.map((label) => {
    //       if (label.id === payload.id) {
    //         label = payload;
    //       }

    //       return label;
    //     });

    //   case 'DELETE_LABEL':
    //     return labels.filter((label) => label.id !== payload);

    //   case 'NEW_LABEL_ADD':
    //     return [...labels, payload];

    default:
      break;
  }
};
