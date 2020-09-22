# Node Sample Application

This application demonstrates the steps toward authentication and authorization for our OAuth system.

## Configuration

Use the provided `.env.sample` template to configure the client.

```
cd samples/oauth_node
cp .env.sample .env
```

## Running with Docker

```
docker build -t oauth-node-sample-client .
docker run --rm -d -p 8080:8080 oauth-node-sample-client
```

Optionally override configuration using environment variables.

```
docker run --rm -d -p 8080:8080 \
  -e CLIENT_ID=FAKE_CLIENT_ID \
  -e CLIENT_SECRET=FAKE_CLIENT_SECRET \
  -e ENVIRONMENT=sandbox \
  oauth-node-sample-client
```

Replace `FAKE_CLIENT_ID` and `FAKE_CLIENT_SECRET` with your ID and secret.

## Running without Docker

### Requirements

* [Node 10.x.x or greater](https://nodejs.org/en/)
* [NPM](https://www.npmjs.com/get-npm)

```
npm i
node index.js
```

## Usage

Navigate to `http://localhost:8080 to begin using the client.
Use any account from the supplied [test accounts](../../test_accounts.md).
