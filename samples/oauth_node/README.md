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

Replace 'FAKE CLIENT ID' and 'FAKE CLIENT SECRET' with your client\_id and client\_secret for VA OAuth then run `node index.js`. You should be able to navigate to `http://localhost:8080/auth` to login and `http://localhost:8080/status` to see the logged in users veteran status. You can use any account in from our supplied [test accounts](../../test-accounts.md) to try it out. 
