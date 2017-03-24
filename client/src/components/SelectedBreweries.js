import React from 'react';

export default function SelectedBreweries(props) {
  const { breweries } = props;

  const breweryRows = breweries.map((brewery, idx) => (
    <tr
      key={idx}
      onClick={() => props.onBreweryClick(idx)}
    >
      <td>{brewery.name}</td>
      <td className='right aligned'>{brewery.description}</td>
    </tr>
  ));

  return (
    <table className='ui selectable structured large table'>
      <thead>
        <tr>
          <th colSpan='5'>
            <h3>Selected Breweries</h3>
          </th>
        </tr>
        <tr>
          <th>name</th>
          <th className='eight wide'>Description</th>
        </tr>
      </thead>
      <tbody>
        {breweryRows}
      </tbody>
    </table>
  );
}
