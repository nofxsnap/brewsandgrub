import * as types from '../actions/actionTypes';
import initialState from './initialState';

export default function courseReducer(state = initialState.foodTruckCalendars, action) {
  switch(action.type) {
    case types.LOAD_FOOD_TRUCK_CALENDARS_SUCCESS:
      return Object.assign([], state, action.foodTruckCalendars);
    default:
      return state;
  }
}