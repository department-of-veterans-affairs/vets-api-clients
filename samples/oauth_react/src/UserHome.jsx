import PropTypes from 'prop-types';
import React, { Component } from 'react';
import snq from 'snq';
import { Header } from 'semantic-ui-react';
import { SignedIn } from './Authentication';

class UserHome extends Component {
  static propTypes = {
    user: PropTypes.object
  };

  render() {
    const name = snq(() => this.props.user.profile.name) || 'Unnamed User';
    return (
      <div>
        <Header as="h1">Sample Third-Party Application</Header>
        <div>
          <p>Welcome back, {name}!</p>
          <p>
            You have successfully authenticated. This application can now access your 
            VA <a href="/servicehistory">Service History</a> and <a href="/disabilityrating">Disability Rating</a> data. 
          </p>
          <p>
            Visit the <a href="/profile">Profile</a> page to take a look inside the ID token
            and see what login information is shared with this application.
          </p>
        </div>
      </div>
    );
  }
}

export default SignedIn.wrapComponent(UserHome);
