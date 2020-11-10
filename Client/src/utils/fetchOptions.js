const getToken = () => {
  return localStorage.getItem('jwtToken');
};

export const getOptions = () => {
  const token = getToken();
  return {
    mode: 'cors',
    credentials: 'include',
    method: 'get',
    headers: {
      Authorization: token,
    },
  };
};

export const postOptions = (data) => {
  const token = getToken();
  return {
    mode: 'cors',
    credentials: 'include',
    method: 'POST',
    headers: {
      Authorization: token,
      'Content-Type': 'application/json;charset=utf-8',
    },
    body: JSON.stringify(data),
  };
};

export const putOptions = () => {
  const token = getToken();
  return {
    mode: 'cors',
    credentials: 'include',
    method: 'put',
    headers: {
      Authorization: token,
    },
  };
};

export const deleteOptions = () => {
  const token = getToken();
  return {
    mode: 'cors',
    credentials: 'include',
    method: 'delete',
    headers: {
      Authorization: token,
    },
  };
};
