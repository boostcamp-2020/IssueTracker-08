import { useState, useEffect } from 'react';

const useFetch = (callback, url, options) => {
  const [loading, setLoading] = useState(false);

  const fetchInitialData = async () => {
    setLoading(true);
    const response = await fetch(url, options);
    const initialData = await response.json();

    if (initialData.status) {
      callback(initialData.data);
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchInitialData();
  }, []);

  return loading;
};

export default useFetch;
