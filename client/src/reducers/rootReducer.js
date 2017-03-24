import {combineReducers} from 'redux';
import breweries from './breweryReducer';
import foodTruckCalendars from './foodTruckCalendarReducer';

const rootReducer = combineReducers({
  // short hand property names
  breweries,
  foodTruckCalendars
})

export default rootReducer;