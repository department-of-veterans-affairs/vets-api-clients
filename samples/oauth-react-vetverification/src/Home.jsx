/*
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and limitations under the License.
 */

import { withAuth } from '@okta/okta-react';
import React, { Component } from 'react';
import { Button, Header } from 'semantic-ui-react';
import { checkAuthentication } from './helpers';
import config from './.samples.config';

export default withAuth(class Home extends Component {
  constructor(props) {
    super(props);
    this.state = { authenticated: null, userinfo: null };
    this.checkAuthentication = checkAuthentication.bind(this);
    this.login = this.login.bind(this);
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

  render() {
    return (
      <div>
        {this.state.authenticated !== null &&
        <div>
          <Header as="h1">Sample Third-Party Application</Header>
          {this.state.authenticated &&
            <div>
              <p>Welcome back, {this.state.userinfo.name}!</p>
              <p>
                You have successfully authenticated. This application can now access your 
                VA <a href="/servicehistory">Service History</a> and <a href="/disabilityrating">Disability Rating</a> data. 
              </p>
              <p>
                Visit the <a href="/profile">Profile</a> page to take a look inside the ID token
                and see what login information is shared with this application.
              </p>
            </div>
          }
          {!this.state.authenticated &&
            <div>
              <p>This is a sample third-party application that uses VA APIs.</p>
              <p>
                Log in below to authenticate using your VA credentials and grant this application
                access to your VA data (service history and disability rating).
              </p>
              <Button id="login-button" primary onClick={this.login}>Login</Button>
            </div>
          }

        </div>
        }
      </div>
    );
  }
});
