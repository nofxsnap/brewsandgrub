import React, {PropTypes} from 'react';
import {Link} from 'react-router';

const FoodTruckList = ({foodTrucks}) => {
  return (
      <ul className="list-group">
        {foodTrucks.map(foodTruck =>
          <li className="list-group-item" key={foodTruck.id}>
            <Link to={'/foodTrucks/' + foodTruck.id}>
              {foodTruck.name}
            </Link>
          </li>
        )}
      </ul>
  );
};

FoodTruckList.propTypes = {
  foodTrucks: PropTypes.array.isRequired
};

export default FoodTruckList;
