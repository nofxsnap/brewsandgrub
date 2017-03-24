import React, {PropTypes} from 'react';
import { Link, IndexLink } from 'react-router';

const Header = () => {
  return (
    <nav>
      <IndexLink to="/" activeClassName="active">Home</IndexLink>
      {" | "}
      <Link to="/breweries" activeClassName="active">Breweries</Link>
      {" | "}
      <Link to="/foodTrucks" activeClassName="active">Food Trucks</Link>
    </nav>
  );
};

export default Header;
