# OAuth React Sample Application

This example shows how to integrate with the VA API platform OAuth implementation and use 
an OAuth token to make API calls. It is a Reacth single page application, built on top of the 
Okta React Library and based on their sample application.

## Prerequisites

Before running this sample, you will need the following:

* Access to the deptva-eval Okta org or an equivalently configured Okta org.
* An Okta appliciation, configured for a single-page app.

## Running This Example

Install dependencies:

```bash
npm install
```

Now you need to gather the following information from the Okta Developer Console:

- **Client Id** - The client ID of the SPA application that you created earlier. This can be found on the "General" tab of an application, or the list of applications.  This identifies the application that tokens will be minted for.
- **Issuer** - This is the URL of the authorization server that will perform authentication.  All Developer Accounts have a "default" authorization server.  The issuer is a combination of your Org URL (found in the upper right of the console home page) and `/oauth2/default`. For example, `https://dev-1234.oktapreview.com/oauth2/default`.
- **API Endpoints** - These are the URLs of the veteran verification API operations that the application calls. May be your local vets-api instance or a dev/staging API endpoint.

Now place these values into the file `src/.samples.config.js` that was created for you in this project:

```javascript
export default {
  oidc: {
    clientId: '{clientId}',
    issuer: 'https://{yourOktaDomain}.com/oauth2/default',
    redirectUri: 'http://localhost:8080/implicit/callback',
    scope: ['openid', 'profile', 'email', 'disability_rating.read', 'service_history.read'],
  },
  resourceServer: {
    serviceHistoryUrl: 'http://localhost:3000/services/veteran_verification/v0/service_history',
    disabilityRatingUrl: 'http://localhost:3000/services/veteran_verification/v0/disability_rating',
  },
};

```

Now start the app server:

```
npm start
```

Now navigate to http://localhost:8080 in your browser.

To change the port, specify the PORT environment variable:
```
PORT=8090 npm start
```

If you see a home page that prompts you to login, then things are working!  Clicking the **Log in** button will redirect you to the Okta hosted sign-in page.

You can log in with an ID.me test account.

