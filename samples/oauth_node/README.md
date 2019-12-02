# Node Sample Application

An explanation of how this works and choices made can be found [here](https://developer.va.gov/oauth).

## Requirements

* [Node 10.x.x or greater](https://nodejs.org/en/)
* [NPM](https://www.npmjs.com/get-npm)

## Installation

* Clone this repository
* `cd samples/oauth_node`
* `npm i`

## Usage

To configure the app, copy `config.example.json` to `config.json` and replace example values with real ones. You must specify a `client_id` and a `client_secret`. You can optionally specify a specific SAML identity provider (i.e., instance of the [SAML proxy](https://github.com/department-of-veterans-affairs/vets-saml-proxy/tree/master/saml-proxy)) to use; this option is mainly for VA developers using the localhost SAML proxy rather than the dev one.

To run the app, run `node index.js` or `npm start`. By default, this application uses the OAuth server defined by [the OpenID configuration](https://dev-api.va.gov/oauth2/.well-known/openid-configuration) hosted at `dev-api.va.gov`. However, if you are using the localhost OAuth server (i.e., instance of the [OAuth proxy](https://github.com/department-of-veterans-affairs/vets-saml-proxy/tree/master/oauth-proxy)), you can use the `--local` option.

```sh
# default OAuth proxy
$ node index.js
$ npm start

# localhost OAuth proxy
$ node index.js --local
$ npm start -- --local
```

You should be able to navigate to `http://localhost:8080/auth` to login and `http://localhost:8080/status` to see the logged in users veteran status. You can use any account in from our supplied [test accounts](../../test-accounts.md) to try it out.

### Config Reference

Required config values:

* `client_id`: Your OAuth client ID in the development environment
* `client_secret`: Your OAuth client secret in the development environment

Optional config values:

* `identity_provider`: The identifier for the SAML proxy IdP you wish to authenticate through. If not specified, the default SAML proxy for the lower environments is used (0oa1pbnlkmlWpo0q22p7). You can also route requests through the localhost SAML proxy (0oa37x2cwf9yOtqGb2p7) if you wish. The default provider is specified in `config.example.json` as an example, but the application will still use the default IdP and work the same. If you are a VA developer, you can read more about using the SAML proxy [here](https://github.com/department-of-veterans-affairs/vets-contrib/tree/master/practice-areas/engineering/Developer%20Process/SAML%20Proxy).
