import React from 'react';
import { labelClasses, inputClasses } from './styles/formClasses';

export default class StatusForm extends React.Component {
  constructor(props) {
    super(props);
    const { guid } = this.props;
    this.state = {
      guid: guid,
    };
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(e) {
    this.setState({ guid: e.target.value });
  }

  render() {
    const { guid } = this.state;
    const { setGuid } = this.props;
    return (
      <div>
        <label id="guid" htmlFor="guid" className={labelClasses}>
          GUID
          <input
            type="text"
            name="guid"
            className={inputClasses}
            value={guid}
            onChange={this.handleChange}
          />
        </label>
        <button
          type="submit"
          className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline w-full"
          onClick={() => setGuid(guid)}
        >
          {' '}
Get Status
        </button>
      </div>
    );
  }
}
