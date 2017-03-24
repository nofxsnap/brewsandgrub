import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import FoodTruckCalendarList from './FoodTruckCalendarList';

class BreweryPage extends React.Component {
  render() {
    return (
      <div className="col-md-8 col-md-offset-2">
        <h1>{this.props.brewery.name}</h1>
        <p>Description: {this.props.brewery.description}</p>
        <FoodTruckCalendarList foodTruckCalendars={this.props.breweryFoodTruckCalendars} />
      </div>
    );
  }
};

BreweryPage.propTypes = {
  brewery: PropTypes.object.isRequired,
  breweryFoodTruckCalendars: PropTypes.array.isRequired
};

function getBreweryById(breweries, id) {
  let brewery = breweries.find(brewery => brewery.id == id)
  return Object.assign({}, brewery)
}

function collectBreweryFoodTruckCalendars(foodTruckCalendars, brewery) {
  let selected = foodTruckCalendars.map(foodTruckCalendar => {
    if (brewery.food_truck_calendar_ids.filter(foodTruckCalendarId => foodTruckCalendarId == foodTruckCalendar.id).length > 0) {
      return foodTruckCalendar;
    }
  })
  return selected.filter(el => el != undefined)
}

function mapStateToProps(state, ownProps) {
  let brewery = {name: '', description: '', food_truck_calendar_ids: []};
  let breweryFoodTruckCalendars = []
  const breweryId = ownProps.params.id;
  if (breweryId && state.breweries.length > 0) {
    brewery = getBreweryById(state.breweries, ownProps.params.id);
    if (brewery.food_truck_calendar_ids && brewery.food_truck_calendar_ids.length > 0 && state.foodTruckCalendars.length > 0) {
      breweryFoodTruckCalendars = collectBreweryFoodTruckCalendars(state.foodTruckCalendars, brewery)
    }
  }
  return {brewery: brewery, breweryFoodTruckCalendars: breweryFoodTruckCalendars};
}

export default connect(mapStateToProps)(BreweryPage);