# OAuth React Sample Application

This example shows how to integrate with the VA API platform OAuth implementation and use 
an OAuth token to make API calls. It is a React single page application, built on top of
the open source `oidc-client` library.

## Prerequisites

Before running this sample, you will need an OAuth client application ID. You can obtain one
by signing up through [the developer portal](https://developer.va.gov).


## Running This Example

Install dependencies:

```bash
npm install
```

Now place these values into the file `src/.samples.config.js` that was created for you in this project:

```javascript
export default {
  oidc: {
    authority: 'https://deptva-eval.okta.com/oauth2/default/.well-known/openid-configuration',
    client_id: '{client_id}',
    redirect_uri: 'http://localhost:8080/implicit/callback',
    scope: ['openid', 'profile', 'email', 'disability_rating.read', 'service_history.read'],
    response_type: 'id_token token',
  },
  resourceServer: {
    serviceHistoryUrl: 'https://sandbox-api.va.gov/services/veteran_verification/v0/service_history',
    disabilityRatingUrl: 'https://sandbox-api.va.gov/services/veteran_verification/v0/disability_rating',
  },
};
```

Here the `{client_id}` should be replaced by your OAuth client application ID.
This config includes the fields needed to auto-configure the [oidc-client npm module](https://www.npmjs.com/package/oidc-client).
To further customize the integration, you can specify [any of the supported options](https://github.com/IdentityModel/oidc-client-js/wiki#usermanager).

Now start the app server:

```
npm start
```

Now navigate to http://localhost:8080 in your browser.

To change the port, specify the PORT environment variable:
```
PORT=8090 npm start
```

If you see a home page that prompts you to login, then things are working!  Clicking the **Log in** button will redirect you to the authorization server.

You can log in with [an ID.me test account](../../test_accounts.md).

