/*
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and limitations under the License.
 */

import React, { Component } from 'react';
import { withAuth } from '@okta/okta-react';
import { Header, Icon, Table } from 'semantic-ui-react';

import { checkAuthentication } from './helpers';

export default withAuth(class Profile extends Component {
  constructor(props) {
    super(props);
    this.state = { userinfo: null, ready: false };
    this.checkAuthentication = checkAuthentication.bind(this);
  }

  async componentDidMount() {
    await this.checkAuthentication();
    this.applyClaims();
  }

  async componentDidUpdate() {
    await this.checkAuthentication();
    this.applyClaims();
  }

  async applyClaims() {
    if (this.state.userinfo && !this.state.claims) {
      const claims = Object.entries(this.state.userinfo);
      this.setState({ claims, ready: true });
    }
  }

  render() {
    return (
      <div>
        {!this.state.ready && <p>Fetching user profile..</p>}
        {this.state.ready &&
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
              {this.state.claims.map((claimEntry) => {
                const claimName = claimEntry[0];
                const claimValue = claimEntry[1];
                const claimId = `claim-${claimName}`;
                return <tr key={claimName}><td>{claimName}</td><td id={claimId}>{claimValue}</td></tr>;
              })}
            </tbody>
          </Table>
        </div>
        }
      </div>
    );
  }
});
