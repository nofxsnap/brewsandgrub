import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import * as breweryActions from '../../actions/breweryActions';
import BreweryList from './BreweryList';

class BreweriesPage extends React.Component {
  render() {
    const breweries = this.props.breweries;
    return (
      <div className="col-md-12">
        <h1>Breweries</h1>
        <div className="col-md-4">
          <BreweryList breweries={this.props.breweries} />
        </div>
        <div className="col-md-8">
          {this.props.children}
        </div>
      </div>
    );
  }
}


BreweriesPage.propTypes = {
  breweries: PropTypes.array.isRequired
};

function mapStateToProps(state, ownProps) {
  // state = {breweries: [{id:1, name: "Maru"}, etc.]}
  return {
    breweries: state.breweries
  };
}

export default connect(mapStateToProps)(BreweriesPage);