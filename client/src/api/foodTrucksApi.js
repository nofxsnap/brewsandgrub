class FoodTrucksApi {
  static getAllFoodTrucks() {
    return fetch('/api/v1/food_trucks').then(response => {
      return response.json();
    }).catch(error => {
      return error;
    });
  }
}

export default FoodTrucksApi;
