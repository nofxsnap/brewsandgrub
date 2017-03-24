import React, {PropTypes} from 'react';
import {connect} from 'react-redux';
import {bindActionCreators} from 'redux';
import * as breweryActions from '../../actions/breweryActions';
import FoodTruckCalendarList from './FoodTruckCalendarList';
import BreweryForm from './BreweryForm'

class BreweryPage extends React.Component {
  constructor(props, context) {
    super(props, context);
    this.state = {
      saving: false,
      isEditing: false,
      brewery: this.props.brewery,
      breweryFoodTruckCalendars: this.props.breweryFoodTruckCalendars
    };
    this.updateBreweryState = this.updateBreweryState.bind(this);
    this.saveBrewery = this.saveBrewery.bind(this);
    this.toggleEdit = this.toggleEdit.bind(this);
  }

  componentWillReceiveProps(nextProps) {
    if (this.props.brewery.id != nextProps.brewery.id) {
      this.setState({brewery: nextProps.brewery});
    }
    this.setState({saving: false, isEditing: false});
  }

  updateBreweryState(event) {
    const field = event.target.name;
    const brewery = this.state.brewery;
    brewery[field] = event.target.value;
    return this.setState({brewery: brewery});
  }

  saveBrewery(event) {
    event.preventDefault();
    this.setState({saving: true});
    this.props.actions.updateBrewery(this.state.brewery);
  }

  toggleEdit() {
    this.setState({isEditing: !this.state.isEditing})
  }

  render() {
    if (this.state.isEditing) {
      return (
      <div>
        <h1>edit brewery</h1>
        <BreweryForm
          brewery={this.state.brewery}
          onSave={this.saveBrewery}
          onChange={this.updateBreweryState}/>
      </div>
      )
    }
    return (
      <div className="col-md-8 col-md-offset-2">
        <h1>{this.props.brewery.name}</h1>
        <p>Description: {this.props.brewery.description}</p>
        <FoodTruckCalendarList foodTruckCalendars={this.props.breweryFoodTruckCalendars} />
        <button onClick={this.toggleEdit}>edit</button>
      </div>
    );
  }
};

BreweryPage.propTypes = {
  brewery: PropTypes.object.isRequired,
  breweryFoodTruckCalendars: PropTypes.array.isRequired,
  actions: PropTypes.object.isRequired
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

function mapDispatchToProps(dispatch) {
  return {
    actions: bindActionCreators(breweryActions, dispatch)
  };
}

export default connect(mapStateToProps, mapDispatchToProps)(BreweryPage);