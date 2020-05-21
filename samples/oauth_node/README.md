# Node Sample Application

An explanation of how this works and choices made can be found [here](https://developer.va.gov/oauth).

## Installation with Docker

```
cd samples/oauth_node
Copy .env.sample to .env
Replace `FAKE_CLIENT_ID` and `FAKE_CLIENT_SECRET` and `ENVIRONMENT` in your copy of `.env` with your ID and secret and target deploy environment

docker build -t oauth-node-sample-client .

docker run --rm -d -p 8080:8080 \
  -e CLIENT_ID=FAKE_CLIENT_ID \
  -e CLIENT_SECRET=FAKE_CLIENT_SECRET \
  oauth-node-sample-client
```

Replace `FAKE_CLIENT_ID` and `FAKE_CLIENT_SECRET` with your ID and secret.

## Installation without Docker

### Requirements

* [Node 10.x.x or greater](https://nodejs.org/en/)
* [NPM](https://www.npmjs.com/get-npm)

```
cd samples/oauth_node
npm i
```

Replace `FAKE_CLIENT_ID` and `FAKE_CLIENT_SECRET` in `.env` with your ID and secret.

```
node index.js
```

## Usage

Navigate to `http://localhost:8080/auth` to login and `http://localhost:8080/status` to see the logged in users veteran status
Use any account from the supplied [test accounts](../../test_accounts.md).
