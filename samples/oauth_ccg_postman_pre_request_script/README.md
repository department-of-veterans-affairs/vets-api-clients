# Postman CCG Pre-request Script Documentation

## Description:

The Postman CCG Pre-request Script simplifies the interaction process for developers working with Lighthouse CCG APIs. This script generates a signed JSON Web Token (JWT) and retrieves an access token, facilitating seamless communication with the Lighthouse API. The Postman collection provided uses the Benefits Claims API, but this does work with other CCG Lighthouse API's.

## Steps to Use:

1. Import the Postman Collection:
    a. Download and import the "CCG Pre-request Script.postman_collection.json" into your Postman workspace.

2. Set Global Variables:
    a. In Postman, set the following global variables along with their corresponding values. Refer to the instructions on https://developer.va.gov/explore/api/benefits-claims/client-credentials for obtaining the values.

    - aud
    - clientId
    - privatePem
    - scope

3. Run "load jsrsasign-js":
    a. Click on the "load jsrsasign-js" request in the Postman Collection.
    b. Click "Send" to execute the request. This step loads the necessary libraries for JWT signing.

4. Run "ccg-api-request":
    a. Click on the "ccg-api-request" request in the Postman Collection.
    b. Click "Send" to execute the request. This step generates a signed JWT and retrieves the access token needed for calling the Lighthouse API.

Note: Ensure that you have valid values for the global variables, as incorrect or missing values may result in authentication issues.

By following these steps, developers can seamlessly authenticate and interact with the Lighthouse CCG APIs using Postman.
