# README

This is a sample app that will connect with the oauth provider to access Veteran Claims APIs.

## Running locally

Set up your API credentials at the [Developer Portal](https://developer.va.gov/apply).  The callback for this app to work needs to be `http://localhost:3000/callback`.

The sample app uses the default SQLite database setup and `rails db:migrate` will generate the sqlite3 file with the table needed to run the app.  **The app expects the file `config/application.yml` to contain a key for `va_developer_client_id` and `va_developer_client_secret`**.  `config/application.yml.EXAMPLE` is an example config (to make sure the credentials file remains untracked in git).  To use it, make a copy without the `.EXAMPLE` extension and fill in your credentials.

## Using the app

The home page will show an "Oauth Login" button.  That will take you to the VA sign-in page.  You can use a [test login](https://github.com/department-of-veterans-affairs/vets-api-clients/blob/master/test_accounts.md).  Once logged in, you will be able to see the claims for a logged in veteran, submit an intent to file, view supporting documents for a claim.

### Exploring the API

Once a valid session has been created, you can use `rails console` to explore the API through code.  Find a Session in the database that is not expired then you can use the _response methods to see the HTTParty::Response object returned when accessing that API.  Calling `.body` on the response will give the raw JSON string, but `[]` can be used on the response object to access values in the response as a hash.

Ex: `Session.last.veteran_verification.confirmed_status_response['data']['attributes']['veteran_status']` will return "confirmed" (if the veteran status is confirmed).

