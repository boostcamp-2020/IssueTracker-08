export const issueReducer = (issues, { type, payload }) => {
  switch (type) {
    case 'SET_INIT_DATA':
      return payload;

    case 'FILTER_AUTHOR':
      return issues.filter((issue) => issue.userId === payload);

    case 'FILTER_LABEL':
      const filterList = [];

      issues.forEach((issue) =>
        issue['label'].forEach((label) => {
          if (label.labelName === payload) {
            filterList.push(issue);
          }
        })
      );

      return filterList;

    default:
      break;
  }
};
