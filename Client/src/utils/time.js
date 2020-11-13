const getMonthName = function (time) {
  const index = time.getMonth();
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return monthNames[index];
};

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

export const getDueDate = (time) => {
  const dueTime = new Date(time);
  const month = getMonthName(dueTime);
  const date = dueTime.getDate();
  const year = dueTime.getFullYear();

  return `${month} ${date}, ${year}`;
};

export const getTimeString = (time) => {
  if (time === null) return 'No due date';
  const createTime = new Date(time);
  const currentTime = new Date();
  if (createTime < currentTime) {
    return `⚡ Past due by ${getDiffTime(time)}`;
  }
  return `📅 Due by ${getDueDate(time)}`;
};

export const getFormatDate = (time) => {
  if (time === null) return '';
  const date = new Date(time);
  const year = date.getFullYear();
  let month = 1 + date.getMonth();
  month = month >= 10 ? month : '0' + month;
  let day = date.getDate();
  day = day >= 10 ? day : '0' + day;
  return year + '-' + month + '-' + day;
};
