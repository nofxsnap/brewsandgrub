import {combineReducers} from 'redux';
import breweries from './breweryReducer';
import foodTrucks from './foodTruckReducer';
import foodTruckCalendars from './foodTruckCalendarReducer';

const rootReducer = combineReducers({
  // short hand property names
  breweries,
  foodTrucks,
  foodTruckCalendars
})

export default rootReducer;
