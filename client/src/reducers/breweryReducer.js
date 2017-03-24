import * as types from '../actions/actionTypes';
import initialState from './initialState';

export default function breweryReducer(state = initialState.breweries, action) {
  switch(action.type) {
    case types.LOAD_BREWERIES_SUCCESS:
      return action.breweries;
    default:
      return state;
  }
}
