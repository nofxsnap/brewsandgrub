import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import {bindActionCreators} from 'redux';
import * as foodTruckActions from '../../actions/foodTruckActions';
import FoodTruckForm from './FoodTruckForm';

class NewFoodTruckPage extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      foodTruck: {name: ''},
      saving: false
    };
    this.saveFoodTruck = this.saveFoodTruck.bind(this);
    this.updateFoodTruckState = this.updateFoodTruckState.bind(this);
  }

  updateFoodTruckState(event) {
    const field = event.target.name;
    const foodTruck = this.state.foodTruck;
    foodTruck[field] = event.target.value;
    return this.setState({foodTruck: foodTruck});
  }

  saveFoodTruck(event) {
    event.preventDefault();
    this.props.actions.createFoodTruck(this.state.foodTruck);
  }

  render() {
    return (
      <div className="col-md-12">
        <h1>New Food Truck</h1>
        <FoodTruckForm
          foodTruck={this.state.foodTruck}
          onSave={this.saveFoodTruck}
          onChange={this.updateFoodTruckState}/>
      </div>
    );
  }
}

NewFoodTruckPage.propTypes = {
  actions: PropTypes.object.isRequired
};

export default NewFoodTruckPage;
