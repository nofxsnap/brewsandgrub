import * as types from './actionTypes';
import foodTrucksApi from '../api/foodTrucksApi';

export function loadFoodTrucks() {
  return function(dispatch) {
    return foodTrucksApi.getAllFoodTrucks().then(foodTrucks => {
      dispatch(loadFoodTrucksSuccess(foodTrucks));
    }).catch(error => {
      throw(error);
    });
  };
}

export function loadFoodTrucksSuccess(foodTrucks) {
  return {type: types.LOAD_FOOD_TRUCKS_SUCCESS, foodTrucks};
}
