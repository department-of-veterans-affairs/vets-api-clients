Postman CCG OAuth Token

Description:

This Postman collection contains pre-script request methods for VA API's using CCG OAuth. It's purpose is to generate an access token using the required test variables.

Configuration:

1. Import "Lighthouse OAuth Token.postman_collection.json" into your Postman workspace.
2. Click on “Lighthouse OAuth Token” in the left column of Postman, to view the collection tabs for "Lighthouse OAuth Token".
3. Click on "Variables" within Postman, to view pre set collection variables.
4. Configure "Lighthouse OAuth Token" collection variables (aud, token_endpoint, clientId, privatePem) in Postman, assigning them their respective values. The client_assertion, import_do_not_edit values should not be edited, as they will be pre-populated once the previous values are defined. Follow the guidance provided at https://developer.va.gov/explore to obtain the necessary collection variable values for API calls. For other APIs, consult the Lighthouse CCG API page related to your desired interaction for accurate API-specific collection variable values. Some example values for the Collection variables following the Patient Health API will be shown below:

a. aud (Collection variable)
Example aud value:
https://deptva-eval.okta.com/oauth2/aus8nm1q0f7VQ0a482p7/v1/token
b. token_endpoint (Collection variable)
Example API tokenUrl value:
https://sandbox-api.va.gov/oauth2/health/system/v1/token
c. clientId (Collection variable)- This value is obtained from signing up for sandbox access using the dev portal link
Example clientId value:
Your CCG clientId

d. privatePem (Collection variable)
Example privatePem value:
-----BEGIN RSA PRIVATE KEY-----
Your private pem
-----END RSA PRIVATE KEY-----

5. Next under the "Lighthouse OAuth Token" click on the actual POST call you will make - "POST Client Credentials Example"

6. You will see that the HTTP url is the {token_endpoint} Collection variable that has already been configured.

7. Then click on "Body" which is located in the middle of the Auth type columns. You should see all values pre-populated and using the x-www-form-urlencoded type. The grant_type and client_assertion_type values should not change as this is a CCG call. The client_assertion should also remain the same as it will be populated with the client_assertion Collection variable. The two configurable values will be the scope and launch based off of the API and call you choose to make. Follow the guidance provided at https://developer.va.gov/explore to obtain the necessary values for APIs.

a. scope
Currently the default value is set to "launch" which is acceptable for certain APIs but can be changed to include more scopes defined on the dev portal site:
https://developer.va.gov/explore

b. launch
In some cases launch will not be required for certain APIs. Follow the documentation to see which APIs require launch. In the cases where launch isn't required, uncheck the "launch" box and the default scope value will also need to change accordingly. Launch is required to be an encoded base64.
Example Value:
eyJwYXRpZW50IjoiMTAwMDcyMDEwMFYyNzEzODcifQ==

Run:

This step will generate a JWT assertion and return an OAuth access token. Users can view the JWT assertion in the console after running "Client Credentials Example".

1. If not already there, click on “Client Credentials Example” in the left column of Postman.

2. Click "Send" on the top right corner.

Note:
If all values were configured correctly, you should see an access_token and other fields corresponding to the API call you made.