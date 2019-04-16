# README

This is a sample app that will connect with the oauth provider to access Veteran Verification APIs.

## Running locally

Set up your API credentials at the [Developer Portal](https://developer.va.gov/apply).  The callback for this app to work needs to be `http://localhost:3000/callback`.

The sample app uses the default SQLite database setup and `rails db:migrate` will generate the sqlite3 file with the table needed to run the app.  **The app expects the file `config/application.yml` to contain a key for `va_developer_client_id` and `va_developer_client_secret`**.  `config/application.yml.EXAMPLE` is an example config (to make sure the credentials file remains untracked in git).  To use it, make a copy without the `.EXAMPLE` extension and fill in your credentials.

# TODO write this up

## This is how the app was created
 -- TODO --- this is copied from the vetverification app
1. rails new oauth_rails_vethealth
2. use figaro to set up application config to hold keys
3. build app features to login and request veteran verification data 
    * login action on auth_controller
    * callback action on auth_controller
    * class for handling Health API calls
      * class for managing service history data
    * health_controller to display data from API
4. the session model was created hide oauth data and authenticate future requests
5. used bootstrap to make things easier on the eyes
    * https://github.com/twbs/bootstrap-rubygem/tree/v4.3.1