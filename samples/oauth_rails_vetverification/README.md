# README

This is a sample app that will connect with the oauth provider to access Veteran Verification APIs.

## Running locally

Set up your API credentials at the [Developer Portal](https://developer.va.gov/apply).  The callback for this app to work needs to be `http://localhost:3000/callback`.

The sample app uses the default SQLite database setup and `rails db:migrate` will generate the sqlite3 file with the table needed to run the app.  **The app expects the file `config/application.yml` to contain a key for `va_developer_client_id` and `va_developer_client_secret`**.  `config/application.yml.EXAMPLE` is an example config (to make sure the credentials file remains untracked in git).  To use it, make a copy without the `.EXAMPLE` extension and fill in your credentials.

## Using the app

The home page will show an "Oauth Login" button.  That will take you to the VA sign-in page.  You can use a [test login](https://github.com/department-of-veterans-affairs/vets-api-clients/blob/master/test_accounts.md).  Once logged in, you will see the /verify page, which will show the confirmed Veteran Status, Service History, and Disability Ratings for the user.  Trying to access /verify directly (without logging in) will have the user redirected to /login because they don't have a session available in the app.

### Exploring the API

Once a valid session has been created, you can use `rails console` to explore the API through code.  Find a Session in the database that is not expired, and use the `veteran_verification` method to get a VeteranVerification object.  Then you can use the _response methods to see the HTTParty::Response object returned when accessing that API.  Calling `.body` on the response will give the raw JSON string, but `[]` can be used on the response object to access values in the response as a hash.

Ex: `Session.last.veteran_verification.confirmed_status_response['data']['attributes']['veteran_status']` will return "confirmed" (if the veteran status is confirmed).

## This is how the app was created
1. rails new oauth_rails_vetverification
2. use figaro to set up application config to hold keys
3. build app features to login and request veteran verification data 
    * login action on auth_controller
    * callback action on auth_controller
    * class for handling Veteran Verification API calls
      * class for managing service history data
    * verification_controller to display data from API
4. the session model was created hide oauth data and authenticate future requests
5. used bootstrap to make things easier on the eyes
    * https://github.com/twbs/bootstrap-rubygem/tree/v4.3.1
