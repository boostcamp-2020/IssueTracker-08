export const getMilestonePercent = (number, total) => {
  const percent = Math.round((number / total) * 100);
  if (percent) {
    return `${percent}%`;
  }
  if (total !== 0) return '100%';
  return '0%';
};
