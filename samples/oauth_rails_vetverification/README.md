# README

This is a sample app that will connect with the oauth provider to access Veteran Verification APIs.

## This is how the app was created
1. rails new oauth_rails_vetverification
2. rails generate controller auth_controller
3. use figaro to set up application config to hold keys
4. build app features to login and request veteran verification data 
  * login action on auth_controller
  * callback action on auth_controller
  * Session model
  * class for handling Veteran Verification API calls
    * class for managing service history data
  * verification_controller to display data from API
5. use session model to authenticate requests
6. used bootstrap to make things easier on the eyes
  * https://github.com/twbs/bootstrap-rubygem/tree/v4.3.1

// TODO more documentation

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
