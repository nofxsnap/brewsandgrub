class FoodTrucksApi {
  static getAllFoodTrucks() {
    return fetch('/api/v1/food_trucks').then(response => {
      return response.json();
    }).catch(error => {
      return error;
    });
  }

  static createFoodTruck(foodTruck) {
    const headers = Object.assign({'Content-Type': 'application/json'}, this.requestHeaders());
    const request = new Request('/api/v1/food_trucks', {
      method: 'POST',
      headers: headers,
      body: JSON.stringify({foodTruck: foodTruck})
    });

    return fetch(request).then(response => {
      return response.json();
    }).catch(error => {
      return error;
    });
  }
}

export default FoodTrucksApi;
