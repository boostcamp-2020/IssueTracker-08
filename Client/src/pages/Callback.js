import { useEffect } from 'react';
import qs from 'qs';
import axios from 'axios';

import * as config from '../config';

function Callback({ history, location }) {
  useEffect(() => {
    async function getToken() {
      const { code } = qs.parse(location.search, {
        ignoreQueryPrefix: true,
      });

      try {
        await axios
          .post(`${config.BASE_URL}auth/github`, {
            code,
          })
          .then((res) => {
            localStorage.setItem('jwtToken', res.data.jwtToken);
          })
          .catch((err) => {
            console.log(err);
          });

        history.push('/');
      } catch (error) {
        history.push('/error');
      }
    }

    getToken();
  }, [location, history]);
  return null;
}

export default Callback;
