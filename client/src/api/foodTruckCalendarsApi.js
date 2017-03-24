class FoodTruckCalendarApi {
  static getAllFoodTruckCalendars() {
    return fetch('/api/v1/food_truck_calendars').then(response => {
      return response.json()
    }).catch(error => {
      return error
    });
  }
};

export default FoodTruckCalendarApi;