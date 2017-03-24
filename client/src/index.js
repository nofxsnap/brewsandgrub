//import 'babel-polyfill';
import React from 'react';
import { render } from 'react-dom';
import configureStore from './store/configureStore';
import { Provider } from 'react-redux';
import { Router, browserHistory } from 'react-router';
import routes from './routes';
import {loadBreweries} from './actions/breweryActions';
import {loadFoodTruckCalendars} from './actions/foodTruckCalendarActions';

const store = configureStore();

store.dispatch(loadBreweries());
store.dispatch(loadFoodTruckCalendars());

render(
  <Provider store={store}>
    <Router history={browserHistory} routes={routes} />
  </Provider>,
  document.getElementById('app')
);
