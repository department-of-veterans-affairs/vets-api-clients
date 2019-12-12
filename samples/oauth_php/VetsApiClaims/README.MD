## Requirements
- PHP >= 7.2
- PHP Extensions
  - *Note: These may be preinstalled on macOS*
  - php-mbstring
  - php-xml
  - php-sqlite
- Composer

##Setup

This will install artisan
- composer global require "laravel/installer"
- Copy the .env.example file to just env
- `php composure install`
- `php artisan key:generate`
- `touch database/database.sqlite`
- Replace the values of the following keys with your unique values
  - API_KEY
  - VA_CLIENT_ID
  - VA_CLIENT_SECRET
  - DB_DATABASE
- `php artisan migrate`

## Running the APP
- at the command line run `php artisan serve --port=3000`


## Notes
To demonstrate techniques, the app uses php's curl as part of the Oauth flow, but when consuming the api (ex. Claims) the app used the PHP Guzzle library. https://guzzle.readthedocs.io/en/latest/index.html
