// This module exports the Authentication element to manage the various
// openid-client objects required to log in and out. It also exports a variety
// of elements to make it easier to consume the authentication context without
// having to care about AuthenticationContext.

import React, { Component } from 'react';
import { Log, UserManager } from 'oidc-client';
import { Button } from 'semantic-ui-react';

const AuthenticationContext = React.createContext({user: null});

class Authentication extends Component {
  constructor(props) {
    super(props);
    this.state = {authenticated: false, user: null};
    this.userManager = new UserManager(this.props.OidcSettings);
    this.userManager.events.addUserLoaded((user) => {
      console.log('user loaded, changing Authentication state');
      this.setState({authenticated: true, user: user});
    });
    this.userManager.events.addUserUnloaded(() => {
      console.log('user unloaded, changing Authentication state');
      this.setState({authenticated: false, user: null});
    });
  }

  componentDidMount() {
    Log.logger = window.console;
    this.userManager.getUser().then((user) => {
      this.setState({authenticated: true, user: user});
      console.log(user)
    });
  }

  render() {
    const ctxValue = {user: this.state.user, userManager: this.userManager, oidcSettings: this.props.oidcSettings};
    return (
      <AuthenticationContext.Provider value={ctxValue}>
        {this.props.children}
      </AuthenticationContext.Provider>
    );
  }
}

class ImplicitCallback extends Component {
  static contextType = AuthenticationContext;

  componentDidMount() {
    this.context.userManager.signinRedirectCallback()
      .then((user) => this.onRedirectSuccess(user))
      .catch((error) => this.onRedirectError(error));
  }

  onRedirectSuccess(user) {
    console.log(user);
    this.props.history.push(`/`)
  }

  onRedirectError(error) {
    console.log(error);
  }

  render() {
    return null;
  }
}


class AuthenticationState extends Component {
  static contextType = AuthenticationContext;

  constructor(props) {
    super(props);
    this.state = {
      authenticated: false,
    }
  }

  componentDidMount() {
    if ((this.state.authenticated === true) && (this.context.user == null)) {
      this.setState({authenticated: false});
    } else if ((this.state.authenticated === false) && (this.context.user != null)) {
      this.setState({authenticated: true});
    }
  }
}

class SignedIn extends AuthenticationState {
  render() {
    if (this.context.user == null) {
      return null;
    } else {
      return React.Children.map(this.props.children, (child, index) => {
        return React.cloneElement(child, { index, user: this.context.user });
      });
    }
  }

  // Returns a function that serves as a stateless component that renders it's
  // children inside a <SignedIn> element.
  static wrapComponent(ComponentClass) {
    return (props) => { return (<SignedIn><ComponentClass {...props} /></SignedIn>) };
  }
}

class SignedOut extends AuthenticationState {
  render() {
    if (this.context.user == null) {
      return this.props.children;
    } else {
      return null;
    }
  }
}

class Mimic extends Component {
  constructor(props) {
    super(props);
    this.onClick = this.onClick.bind(this);
  }

  render() {
    const ElementType = this.props.as || Button;
    return (
      <ElementType onClick={this.onClick} {...this.props}>{this.props.children}</ElementType>
    );
  }
}

class SignInButton extends Mimic {
  static contextType = AuthenticationContext;
  onClick() {
    this.context.userManager.signinRedirect();
  }
}

class SignOutButton extends Mimic {
  static contextType = AuthenticationContext;
  onClick() {
    this.context.userManager.signoutRedirect();
  }
}

export { Authentication, ImplicitCallback, SignInButton, SignOutButton, SignedIn, SignedOut };
