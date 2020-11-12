import React, { useEffect, useState } from 'react';
import { getOptions } from '../../utils/fetchOptions';
import { GET_COMMENTS } from '../../utils/api.js';

export default function OtherComments({ issueId }) {
  console.log(issueId);
  const [comments, setComments] = useState('');

  const getComments = async () => {
    const options = getOptions();
    const response = await fetch(GET_COMMENTS(issueId), options);
    // const responseJSON = await response.json();
    // console.log(responseJSON);
    // setComments(responseJSON.data[0]);
    // console.log(responseJSON.data[0]);
    // console.log(setComments);
  };

  useEffect(() => {
    getComments();
  }, []);

  return <p>코멘츠</p>;
}
