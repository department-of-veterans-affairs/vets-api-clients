# README

This is a sample app that will connect with the oauth provider to access Health APIs.  It is designed to give extra detail about the steps involved in oauth and show the raw responses from the various APIs.  These APIs are described [here](https://developer.va.gov/explore/health/docs/argonaut).  (Note, the `metadata` endpoint is publicly accessible and not used in this app because no OAuth is necessary.)

## Running locally

Set up your API credentials at the [Developer Portal](https://developer.va.gov/apply).  The callback for this app to work needs to be `http://localhost:3000/callback`.

The sample app uses the default SQLite database setup and `rails db:migrate` will generate the sqlite3 file with the table needed to run the app.  **The app expects the file `config/application.yml` to contain a key for `va_developer_client_id` and `va_developer_client_secret`**.  `config/application.yml.EXAMPLE` is an example config (to make sure the credentials file remains untracked in git).  To use it, make a copy without the `.EXAMPLE` extension and fill in your credentials.

## Exploring the Health APIs

The main page of the app will ask you to log in through `ID.me`.  [These test accounts](https://github.com/department-of-veterans-affairs/vets-api-clients/blob/master/test_accounts.md#health-api-accounts) will log in to the dev Health APIs.  The main page will explain all the parameters passed into the request for OAuth.

After successfully logging in to the OAuth server it will open the the designated callback page in your app.  Typically this endpoint would set up a session and redirect to the main functionality of your app.  In this app, instead of redirecting, the callback information is all shown and explained.  The code for the `session_controller#callback` action is more complex to support all the information it can display as well as storing callack information in the session to support refreshing this page.  (The [sample app for veteran verification](https://github.com/department-of-veterans-affairs/vets-api-clients/tree/master/samples/oauth_rails_vetverification) has a callback designed more like a practical app would.)

Once the callback page shows a new session, you can follow the link to explore the Health API.  Click on any of the links to have the `auth_token` used to request data for the logged in user from the given API endpoints.  The raw json returned will be shown.
