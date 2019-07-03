import React from 'react';
import { labelClasses, inputClasses } from './styles/formClasses';

function handleNumberLength(event) {
  if (event.target.value.length >= 9) {
    event.preventDefault();
    event.stopPropagation();
  }
}

const initialState = {
  firstName: '',
  lastName: '',
  email: '',
  fileNumber: '',
  comments: '',
  docType: '',
  files: [],
};

export default class Form extends React.Component {
  constructor(props) {
    super(props);
    this.state = initialState;
    this.handleChange = this.handleChange.bind(this);
    this.handleFiles = this.handleFiles.bind(this);
  }

  handleChange(event) {
    this.setState({ [event.target.name]: event.target.value });
  }

  handleFiles(event) {
    const eventFiles = Array.from(event.target.files);
    const { files } = this.state;
    if (event.target.name === 'mainFile') {
      files.shift();
      this.setState({ files: [...eventFiles, ...files] });
    } else {
      this.setState({ files: [files[0], ...eventFiles] });
    }
  }

  render() {
    const { handleSubmit } = this.props;
    return (
      <div className="bg-white shadow-md rounded w-1/2">
        <form className="px-8 pt-6 pb-8 mb-4">
          <label htmlFor="docType" className={labelClasses}>
            Doc Type
            <input
              type="text"
              name="docType"
              id="docType"
              className={inputClasses}
              value={this.state.docType}
              onChange={this.handleChange}
            />
          </label>

          <label htmlFor="veterans-first-name" className={labelClasses}>
            Veteran&apos;s First Name
            <input
              type="text"
              name="firstName"
              id="veterans-first-name"
              className={inputClasses}
              value={this.state.firstName}
              onChange={this.handleChange}
            />
          </label>

          <label className={labelClasses} htmlFor="veterans-last-name">
            Veteran&apos;s Last Name
            <input
              type="text"
              name="lastName"
              id="veterans-last-name"
              className={inputClasses}
              value={this.state.lastName}
              onChange={this.handleChange}
            />
          </label>

          <label className={labelClasses} htmlFor="email-address">
            Email Address
            <input
              type="email"
              name="email"
              id="email-address"
              className={inputClasses}
              value={this.state.email}
              onChange={this.handleChange}
            />
          </label>

          <label className={labelClasses} htmlFor="fileNumber">
            File Number or SSN (no hyphens or spaces)
            <input
              type="number"
              name="fileNumber"
              id="veterans-file-number"
              className={inputClasses}
              value={this.state.fileNumber}
              onKeyPress={handleNumberLength}
              onChange={this.handleChange}
            />
          </label>

          <label className={labelClasses} htmlFor="mainFile">
            Main File
            <input
              type="file"
              name="mainFile"
              id="files"
              className={inputClasses}
              onChange={this.handleFiles}
              required
              multiple
            />
          </label>

          <label className={labelClasses} htmlFor="supportFiles">
            Supporting Files
            <input
              type="file"
              name="supportingFiles"
              id="files"
              className={inputClasses}
              onChange={this.handleFiles}
              multiple
            />
          </label>

          <button
            type="submit"
            className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline w-full"
            onClick={(e) => {
              e.preventDefault();
              handleSubmit(this.state);
            }
            }
          >
            Upload files to VA
          </button>
        </form>
      </div>
    );
  }
}
