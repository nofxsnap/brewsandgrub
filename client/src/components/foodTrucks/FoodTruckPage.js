import React, {PropTypes} from 'react';
import {connect} from 'react-redux';

class FoodTruckPage extends React.Component {
  render() {
    return (
      <div className="col-md-8 col-md-offset-2">
        <h1>{this.props.foodTruck.name}</h1>
        <p>Description: {this.props.foodTruck.description}</p>
      </div>
    );
  }
};

FoodTruckPage.propTypes = {
  foodTruck: PropTypes.object.isRequired
};

function getFoodTruckById(foodTrucks, id) {
  let foodTruck = foodTrucks.find(foodTruck => foodTruck.id == id)
  return Object.assign({}, foodTruck)
}

function mapStateToProps(state, ownProps) {
  let foodTruck = {name: '', description: ''};
  const foodTruckId = ownProps.params.id;
  if (foodTruckId && state.foodTrucks.length > 0) {
    foodTruck = getFoodTruckById(state.foodTrucks, ownProps.params.id);
  }
  return {foodTruck: foodTruck};
}

export default connect(mapStateToProps)(FoodTruckPage);
