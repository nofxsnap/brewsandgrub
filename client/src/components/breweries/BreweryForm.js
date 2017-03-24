import React, {PropTypes} from 'react';
import TextInput from '../common/TextInput';

class BreweryForm extends React.Component {
  render() {
    return (
      <div>
        <form>
          <TextInput
            name="name"
            label="name"
            value={this.props.brewery.name}
            onChange={this.props.onChange}/>

          <TextInput
            name="description"
            label="Description"
            value={this.props.brewery.description}
            onChange={this.props.onChange}/>

          <input
            type="submit"
            disabled={this.props.saving}
            value={this.props.saving ? 'Saving...' : 'Save'}
            className="btn btn-primary"
            onClick={this.props.onSave}/>
        </form>
      </div>
  );
  }
}

BreweryForm.propTypes = {
  brewery: React.PropTypes.object.isRequired,
  onSave: React.PropTypes.func.isRequired,
  onChange: React.PropTypes.func.isRequired
};

export default BreweryForm;