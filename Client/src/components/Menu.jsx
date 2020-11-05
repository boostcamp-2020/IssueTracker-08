import React from 'react';
import { Link } from 'react-router-dom';

const Menu = () => {
  return (
    <div>
      <ul>
        <li>
          <Link to="/login">Login</Link>
        </li>
      </ul>
      <hr />
    </div>
  );
};

export default Menu;
