# Postman CCG Pre-request Script

## Description:

Enhance your developer experience with the Postman CCG Pre-request Script, streamlining interactions with Lighthouse CCG APIs. This script effortlessly produces a signed JSON Web Token (JWT) and fetches an access token, ensuring smooth communication with Lighthouse APIs. While the provided Postman collection focuses on the Benefits Claims API, it seamlessly adapts to other CCG Lighthouse APIs. Simply configure the necessary collection variables (aud, clientId, privatePem, scope) in Postman to tailor it to your chosen API interaction.

## Steps to Use:

1. Import the Postman Collection:

    a. Download and import the "CCG Pre-request Script.postman_collection.json" into your Postman workspace.

2. Set Collection Variables:

Configure collection variables (aud, clientId, privatePem, scope) in Postman, assigning them their respective values. Follow the guidance provided at https://developer.va.gov/explore/api/benefits-claims/client-credentials to obtain the necessary collection variable values for the Benefits Claims API. For other APIs, consult the Lighthouse CCG API page related to your desired interaction for accurate API-specific collection variable values.

    a. aud (Collection variable)
    Example aud value: https://deptva-eval.okta.com/oauth2/ausdg7guis2TYDlFe2p7/v1/token

    b. clientId (Collection variable)
    Example clientId value: your ccg client id

    c. privatePem (Collection variable)
    Example privatePem value:
    -----BEGIN RSA PRIVATE KEY-----
    your private pem
    -----END RSA PRIVATE KEY-----

    d. scope (Collection variable)
    Example scope value: system/claim.read system/claim.write

3. Run "ccg-api-request":

This step generates a signed JWT and retrieves the access token needed for calling the Lighthouse API of choice.

    a. Click on “ccg-api-request” in the left column of Postman (under the CCG Pre-request Script Collection). The pre-configured HTTP call will appear.
    
    b. Click "Send".

Note: Ensure that you have valid values for the collection variables, as incorrect or missing values may result in authentication issues.

By following these steps, developers can seamlessly authenticate and interact with the Lighthouse CCG APIs using Postman.