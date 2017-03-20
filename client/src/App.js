import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import SelectedBreweries from './selectedBreweries';
import Search from './search';

class App extends Component {
  state = {
    selectedBreweries: [],
  }

  render() {
    const { selectedBreweries } = this.state;

    return (
      <div className="App">
        <div className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h2>Welcome to Brews and Grub</h2>
        </div>
        <p className="App-intro">
          <img src="https://s3-us-west-2.amazonaws.com/brewsandgrub/brews_and_grub_temp.jpg" alt="brews and grub" />
          <br />
          To get started, edit <code>src/App.js</code> and save to reload.
        </p>
        <SelectedBreweries
            breweries={selectedBreweries}
            onBreweryClick={this.removeBreweryItem}
          />
        <Search
            itemType="breweries"
            onItemClick={this.addItem}
          />
      </div>
    );
  }
}

export default App;
