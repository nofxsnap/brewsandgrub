class BreweriesApi {
  static getAllBreweries() {
    return fetch('/api/v1/breweries').then(response => {
      return response.json();
    }).catch(error => {
      return error;
    });
  }
}

export default BreweriesApi;