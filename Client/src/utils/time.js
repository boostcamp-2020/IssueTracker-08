export const getDiffTime = (time) => {
  const createTime = new Date(time);
  const currentTime = new Date();
  const diffSecond = (currentTime.getTime() - createTime.getTime()) / 1000;

  if (diffSecond < 60) {
    return `${parseInt(diffSecond)} seconds`;
  }

  if (diffSecond < 3600) {
    return `${parseInt(diffSecond / 60)} minutes`;
  }

  if (diffSecond < 216000) {
    return `${parseInt(diffSecond / 60 / 60)} hours`;
  }

  return `${parseInt(diffSecond / 60 / 60 / 24)} days`;
};

export const getTimeString = (time) => {
  console.log(time);
  return time;
};
