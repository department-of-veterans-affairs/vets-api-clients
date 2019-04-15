# README

This is a sample app that will connect with the oauth provider to access Veteran Verification APIs.

## Running locally

The sample app uses the default SQLite database setup.  The app expects the file `config/application.yml` to contain a key for `va_developer_client_id` and `va_developer_client_secret` using your credentials set up at the [Developer Portal](https://developer.va.gov/apply).  The callback for this app to work needs to be `http://localhost:3000/callback`.

## Using the app

The home page will show an "Oauth Login" button.  That will take you to the VA sign-in page.  You can use a [test login](https://github.com/department-of-veterans-affairs/vets-api-clients/blob/master/test_accounts.md).  Once logged in, you will see the /verify page, which will show the confirmed Veteran Status, Service History, and Disability Ratings for the user.  Trying to access /verify directly (without logging in) will have the user redirected to /login because they don't have a session available in the app.

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
