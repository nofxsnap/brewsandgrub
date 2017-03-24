import * as types from './actionTypes';
import foodTruckCalendarsApi from '../api/foodTruckCalendarsApi';

export function loadFoodTruckCalendarsSuccess(foodTruckCalendars) {
  return {type: types.LOAD_FOOD_TRUCK_CALENDARS_SUCCESS, foodTruckCalendars};
}

export function loadFoodTruckCalendars() {
  return function(dispatch) {
    return foodTruckCalendarsApi.getAllFoodTruckCalendars().then(foodTruckCalendars => {
      dispatch(loadFoodTruckCalendarsSuccess(foodTruckCalendars));
    }).catch(error => {
      throw(error);
    });
  };
}