import * as types from './actionTypes';
import breweriesApi from '../api/breweriesApi';

export function loadBreweries() {
  return function(dispatch) {
    return breweriesApi.getAllBreweries().then(breweries => {
      dispatch(loadBreweriesSuccess(breweries));
    }).catch(error => {
      throw(error);
    });
  };
}

export function updateBrewery(brewery) {
  return function (dispatch) {
    return breweriesApi.updateBrewery(brewery).then(responseBrewery => {
      dispatch(updateBrewerySuccess(responseBrewery));
    }).catch(error => {
      throw(error);
    });
  };
}

export function loadBreweriesSuccess(breweries) {
  return {type: types.LOAD_BREWERIES_SUCCESS, breweries};
}

export function updateBrewerySuccess(brewery) {
  return {type: types.UPDATE_BREWERY_SUCCESS, brewery}
}