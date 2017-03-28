import * as types from './actionTypes';
import foodTrucksApi from '../api/foodTrucksApi';

export function loadFoodTrucksSuccess(foodTrucks) {
  return {type: types.LOAD_FOOD_TRUCKS_SUCCESS, foodTrucks};
}

export function createFoodTruckSuccess(foodTruck) {
  return {type: types.CREATE_FOOD_TRUCK_SUCCESS, foodTruck}
}

export function loadFoodTrucks() {
  return function(dispatch) {
    return foodTrucksApi.getAllFoodTrucks().then(foodTrucks => {
      dispatch(loadFoodTrucksSuccess(foodTrucks));
    }).catch(error => {
      throw(error);
    });
  };
}

export function createFoodTrucks(foodTruck) {
  return function(dispatch) {
    return foodTrucksApi.createFoodTruck(foodTruck).then(responseFoodTruck => {
      dispatch(createFoodTruckSuccess(responseFoodTruck));
      return responseFoodTruck;
    }).catch(error => {
      throw(error);
    });
  };
}
