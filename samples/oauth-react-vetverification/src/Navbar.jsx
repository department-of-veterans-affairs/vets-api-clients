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

import { withAuth } from '@okta/okta-react';
import React, { Component } from 'react';
import { Container, Image, Menu } from 'semantic-ui-react';
import { checkAuthentication } from './helpers';
import config from './.samples.config';

export default withAuth(class Navbar extends Component {
  constructor(props) {
    super(props);
    this.state = { authenticated: null };
    this.checkAuthentication = checkAuthentication.bind(this);
    this.login = this.login.bind(this);
    this.logout = this.logout.bind(this);
  }

  async componentDidMount() {
    this.checkAuthentication();
  }

  async componentDidUpdate() {
    this.checkAuthentication();
  }

  async login() {
    this.props.auth.login('/', {
      idp: config.oidc.idp
    });
  }

  async logout() {
    this.props.auth.logout('/');
  }

  render() {
    return (
      <div>
        <Menu fixed="top" inverted>
          <Container>
            <Menu.Item as="a" header href="/">
              <Image size="mini" src="/adhoc.png" />
              &nbsp;&nbsp;
              Sample VA API App
            </Menu.Item>
            {this.state.authenticated === true && <Menu.Item id="servicehistory-button" as="a" href="/servicehistory">Service History</Menu.Item>}
            {this.state.authenticated === true && <Menu.Item id="disability-button" as="a" href="/disabilityrating">Disability Rating</Menu.Item>}
            {this.state.authenticated === true && <Menu.Item id="profile-button" as="a" href="/profile">Profile</Menu.Item>}
            {this.state.authenticated === true && <Menu.Item id="logout-button" as="a" onClick={this.logout}>Logout</Menu.Item>}
            {this.state.authenticated === false && <Menu.Item as="a" onClick={this.login}>Login</Menu.Item>}
          </Container>
        </Menu>
      </div>
    );
  }
});
