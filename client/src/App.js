import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class App extends Component {
  render() {
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
      </div>
    );
  }
}

export default App;
