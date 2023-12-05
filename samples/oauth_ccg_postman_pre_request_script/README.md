# Postman CCG Pre-request Script

## Description:

This Postman collection contains pre-script request methods for VA API's using CCG OAuth. It generates a JWT assertion, requests an OAuth access token, and shows an example call interacting with the Benefits Claims API.

## Configuration:

1. Import the Postman Collection:

    a. Import the "CCG Pre-request Script.postman_collection.json" into your Postman workspace.

2. Set Collection Variables:

Configure collection variables (aud, clientId, privatePem, scope) in Postman, assigning them their respective values. Follow the guidance provided at https://developer.va.gov/explore/api/benefits-claims/client-credentials to obtain the necessary collection variable values for the Benefits Claims API. For other APIs, consult the Lighthouse CCG API page related to your desired interaction for accurate API-specific collection variable values.

    a. aud (Collection variable)
    Example Benefits Claims API aud value: https://deptva-eval.okta.com/oauth2/ausdg7guis2TYDlFe2p7/v1/token

    b. clientId (Collection variable)
    Example clientId value: your ccg client id

    c. privatePem (Collection variable)
    Example privatePem value:
    -----BEGIN RSA PRIVATE KEY-----
    your private pem
    -----END RSA PRIVATE KEY-----

    d. scope (Collection variable)
    Example Benefits Claims API scope value: system/claim.read system/claim.write

## Run:

1. Run "ccg-api-request":

This step generates a JWT assertion, requests an OAuth access token, and shows an example call interacting with the Lighthouse API of choice.

    a. Click on “ccg-api-request” in the left column of Postman (under the CCG Pre-request Script Collection). The pre-configured HTTP call will appear.
    
    b. Click "Send".

Note: Ensure that you have valid values for the collection variables, as incorrect or missing values may result in issues.