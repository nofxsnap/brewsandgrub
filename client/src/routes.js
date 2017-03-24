import React from 'react';
import { Route, IndexRoute } from 'react-router';
import App from './components/App';
import HomePage from './components/home/HomePage';
import BreweriesPage from './components/breweries/BreweriesPage';
import BreweryPage from './components/breweries/BreweryPage';

export default (
  <Route path="/" component={App}>
    <IndexRoute component={HomePage} />
    <Route path="/breweries" component={BreweriesPage} >
      <Route path="/breweries/:id" component={BreweryPage} />
    </Route>
  </Route>
);