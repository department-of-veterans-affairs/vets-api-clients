/*
 * Copyright (c) 2018, Okta, Inc. and/or its affiliates. All rights reserved.
 * This file has been modified from the original.
 * Modifications are subject to the CC0 1.0 Universal public domain dedication.
 *
 * The Okta software accompanied by this notice is provided pursuant to the Apache License, Version 2.0 (the "License.")
 *
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and limitations under the License.
 */

import PropTypes from 'prop-types';
import React, { Component } from 'react';
import { Header, Icon, Table } from 'semantic-ui-react';
import { SignedIn } from './Authentication';

class Profile extends Component {
  static propTypes = {
    user: PropTypes.object
  };

  renderEmptyState() {
    return <div><p>Your user info is unavailable.</p></div>;
  }

  renderProfileDetails() {
    const Claim = ({claimName, claimValue}) => {
      const claimId = `claim-${claimName}`;
      return <tr key={claimName}><td>{claimName}</td><td id={claimId}>{claimValue}</td></tr>;
    };

    return (
      <div>
        <Header as="h1"><Icon name="drivers license outline" /> My User Profile (ID Token Claims) </Header>
        <p>
          Below is the information from your ID token. This information is shared with this third party application when you sign in.
        </p>
        <Table>
          <thead>
            <tr>
              <th>Claim</th><th>Value</th>
            </tr>
          </thead>
          <tbody>
            {Object.entries(this.props.user.profile).map((claim, idx) => {
              return Claim({claimName: claim[0], claimValue: claim[1]});
            })}
          </tbody>
        </Table>
      </div>
    );
  }

  render() {
    return (this.props.user == null) ? this.renderEmptyState() : this.renderProfileDetails();
  }
}

export default SignedIn.wrapComponent(Profile);
