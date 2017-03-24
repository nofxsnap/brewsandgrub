import * as types from '../actions/actionTypes';
import initialState from './initialState';

export default function breweryReducer(state = initialState.breweries, action) {
  switch(action.type) {
    case types.LOAD_BREWERIES_SUCCESS:
      return action.breweries;
    case types.UPDATE_BREWERY_SUCCESS:
      return [
        ...state.filter(brewery => brewery.id !== action.brewery.id),
        Object.assign({}, action.brewery)
      ]
    default:
      return state;
  }
}
