import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import * as foodTruckActions from '../../actions/foodTruckActions';

class NewFoodTruckPage extends React.Component {
  render() {
    return (
      <div className="col-md-12">
        <h1>Food Trucks</h1>
      </div>
    );
  }
}

export default NewFoodTruckPage;
