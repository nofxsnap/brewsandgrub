class BreweriesApi {
  static getAllBreweries() {
    return fetch('/api/v1/breweries').then(response => {
      return response.json();
    }).catch(error => {
      return error;
    });
  }

  static updateBrewery(brewery) {
    const request = new Request(`/api/v1/breweries/${brewery.id}`, {
      method: 'PUT',
      headers: new Headers({
        'Content-Type': 'application/json'
      }),
      body: JSON.stringify({brewery: brewery})
    });

    return fetch(request).then(response => {
      return response.json();
    }).catch(error => {
      return error;
    });
  }
}

export default BreweriesApi;