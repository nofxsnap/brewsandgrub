import * as types from '../actions/actionTypes';
import initialState from './initialState';

export default function foodTruckReducer(state = initialState.foodTrucks, action) {
  switch(action.type) {
    case types.LOAD_FOOD_TRUCKS_SUCCESS:
      return action.foodTrucks;
    default:
      return state;
  }
}
