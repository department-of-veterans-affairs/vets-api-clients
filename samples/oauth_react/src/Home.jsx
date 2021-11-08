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

import React, { Component } from 'react';
import { Button, Header } from 'semantic-ui-react';
import { SignInButton } from './Authentication';

class Home extends Component {
  render() {
    return (
      <div>
        <Header as="h1">Sample Third-Party Application</Header>
        <div>
          <p>This is a sample third-party application that uses VA APIs.</p>
          <p>
            Log in below to authenticate using your VA credentials and grant this application
            access to your VA data (service history and disability rating).
          </p>
          <SignInButton id="login-button" primary as={Button}>Log In</SignInButton>
        </div>
      </div>
    );
  }
}

export default Home;
