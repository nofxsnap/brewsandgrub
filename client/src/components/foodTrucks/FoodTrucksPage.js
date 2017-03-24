import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import * as foodTruckActions from '../../actions/foodTruckActions';
import FoodTruckList from './FoodTruckList';

class FoodTrucksPage extends React.Component {
  render() {
    const foodTrucks = this.props.foodTrucks;
    return (
      <div className="col-md-12">
        <h1>Food Trucks</h1>
        <div className="col-md-4">
          <FoodTruckList foodTrucks={this.props.foodTrucks} />
        </div>
        <div className="col-md-8">
          {this.props.children}
        </div>
      </div>
    );
  }
}


FoodTrucksPage.propTypes = {
  foodTrucks: PropTypes.array.isRequired
};

function mapStateToProps(state, ownProps) {
  return {
    foodTrucks: state.foodTrucks
  };
}

export default connect(mapStateToProps)(FoodTrucksPage);
