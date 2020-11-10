export const getOptions = {
  mode: 'cors',
  credentials: 'include',
  method: 'get',
  headers: {
    Authorization: localStorage.getItem('jwtToken'),
  },
};

export const postOptions = (data) => {
  return {
    mode: 'cors',
    credentials: 'include',
    method: 'POST',
    headers: {
      Authorization: localStorage.getItem('jwtToken'),
      'Content-Type': 'application/json;charset=utf-8',
    },
    body: JSON.stringify(data),
  };
};

export const putOptions = {
  mode: 'cors',
  credentials: 'include',
  method: 'put',
  headers: {
    Authorization: localStorage.getItem('jwtToken'),
  },
};

export const deleteOptions = {
  mode: 'cors',
  credentials: 'include',
  method: 'delete',
  headers: {
    Authorization: localStorage.getItem('jwtToken'),
  },
};
