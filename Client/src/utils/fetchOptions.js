// const token = localStorage.getItem('jwt');

export const getOptions = {
  mode: 'cors',
  credentials: 'include',
  method: 'get',
  //   headers: {
  //     Authorization: token,
  //   },
};

export const postOptions = (data) => {
  return {
    mode: 'cors',
    credentials: 'include',
    method: 'POST',
    headers: {
      // Authorization: token,
      'Content-Type': 'application/json;charset=utf-8',
    },
    body: JSON.stringify(data),
  };
};

export const putOptions = {
  mode: 'cors',
  credentials: 'include',
  method: 'put',
};

export const deleteOptions = {
  mode: 'cors',
  credentials: 'include',
  method: 'delete',
};
