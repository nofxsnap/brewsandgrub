import React, {PropTypes} from 'react';
import {Link} from 'react-router';

const BreweryList = ({breweries}) => {
  return (
      <ul className="list-group">
        {breweries.map(brewery =>
          <li className="list-group-item" key={brewery.id}>
            <Link to={'/breweries/' + brewery.id}>
              {brewery.name}
            </Link>
          </li>
        )}
      </ul>
  );
};

BreweryList.propTypes = {
  breweries: PropTypes.array.isRequired
};

export default BreweryList;