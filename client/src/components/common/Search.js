
import React from 'react';
import Client from './Client';

const MATCHING_ITEM_LIMIT = 25;

class Search extends React.Component {
  state = {
    items: [],
    showRemoveIcon: false,
    searchValue: '',
  };

  handleSearchChange = (e) => {
    const value = e.target.value;

    this.setState({
      searchValue: value,
    });

    if (value === '') {
      this.setState({
        items: [],
        showRemoveIcon: false,
      });
    } else {
      this.setState({
        showRemoveIcon: true,
      });

      Client.search(this.props.itemType, value, (items) => {
        this.setState({
          items: items.slice(0, MATCHING_ITEM_LIMIT),
        });
      });
    }
  };

  handleSearchCancel = () => {
    this.setState({
      items: [],
      showRemoveIcon: false,
      searchValue: '',
    });
  };

  render() {
    const { showRemoveIcon, items } = this.state;
    const removeIconStyle = showRemoveIcon ? {} : { visibility: 'hidden' };

    const itemRows = items.map((item, idx) => (
      <tr
        key={idx}
        onClick={() => this.props.onItemClick(item)}
      >
        <td>{item.name}</td>
        <td className='right aligned'>{item.description}</td>
      </tr>
    ));

    return (
      <div id='item-search'>
        <table className='ui selectable structured large table'>
          <thead>
            <tr>
              <th colSpan='5'>
                <div className='ui fluid search'>
                  <div className='ui icon input'>
                    <input
                      className='prompt'
                      type='text'
                      placeholder='Search...'
                      value={this.state.searchValue}
                      onChange={this.handleSearchChange}
                    />
                    <i className='search icon' />
                  </div>
                  <i
                    className='remove icon'
                    onClick={this.handleSearchCancel}
                    style={removeIconStyle}
                  />
                </div>
              </th>
            </tr>
            <tr>
              <th>Name</th>
              <th className='eight wide'>Description</th>
            </tr>
          </thead>
          <tbody>
            {itemRows}
          </tbody>
        </table>
      </div>
    );
  }
}

export default Search;
