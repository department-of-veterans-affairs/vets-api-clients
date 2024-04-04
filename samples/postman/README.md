# Postman Client Credentials Grant (CCG) OAuth Token Request

## Description

This Postman collection contains pre-script request methods to generate a signed JSON Web Token (JWT) and use it as a client assertion to request access tokens from VA APIs with the Client Credentials Grant (CCG) OAuth flow.

-  To retrieve a sandbox token, configure the collection variables and run the token request as shown below. 
-  For information on signing up for sandbox access for a VA API, and if an API uses CCG for authorization, check its documentation pages on the [VA developer portal](https://developer.va.gov/explore).

## Configuration

1. Import `Lighthouse OAuth Token.postman_collection.json` into your Postman workspace.
2. Select the **Lighthouse OAuth Token** collection, in the left column of the Postman window.
3. Select the **Variables** tab.
4. Configure the 4 variables shown below by pasting them into the **Initial Value** and **Current Value** columns in Postman:
    - `aud`: The URL that will recieve your token. 
        - To find this value, check the CCG documentation for the VA API you are working with.
        - Example (from Patient Health API): `https://deptva-eval.okta.com/oauth2/aus8nm1q0f7VQ0a482p7/v1/token`
    - `token_endpoint`: The URL you will request a token from.
        - To find this value, check the CCG documentation for the VA API you are working with.
        - Example (from Patient Health API): `https://sandbox-api.va.gov/oauth2/health/system/v1/token`
    - `clientId`: The Client ID you recieved when you signed up for sandbox access.
        - For information on signing up for sandbox access, check the documentation for the API you are working with in the [VA developer portal](https://developer.va.gov/explore).
    - `privatePem`: The private RSA key you generated when signing up for sandbox access, in PEM format.
        - Your private RSA key should begin with `-----BEGIN RSA PRIVATE KEY-----` and end with `-----END RSA PRIVATE KEY-----`.
        - For information on generating your RSA keys, check the CCG documentation for the API you are working with in the [VA developer portal](https://developer.va.gov/explore).
5. Do **not** edit the `client_assertion` and `import_do_not_edit` values. These will be pre-populated once the previous values are defined. 
6. Now you're ready to request a token. Select **POST Client Credentials Example**, under **Lighthouse OAuth Token** in the left column of the Postman window.
    - You should see that the HTTP URL is the `{token_endpoint}` collection variable that you configured in step `4`, above.
7. Select the **Body** tab.
8. Configure the `scope` and `launch` values as follows:
    - `scope`: The default value, "launch," is only appropriate for some VA APIs. Check the documentation for the API you are working with in the [VA developer portal](https://developer.va.gov/explore) for the correct scope(s) to set in your token request. 
    - `launch`: Follow the steps below to set or omit this value:
        1. Check the documentation for the API you are working with in the [VA developer portal](https://developer.va.gov/explore) to see if `launch` is required.
        2. If `launch` **is** required for your API, enter the correct value as shown in the documentation. This should be a Base64-encoded value that looks similar to the default set in the Postman collection (`eyJwYXRpZW50IjoiMTAwMDcyMDEwMFYyNzEzODcifQ==`).
        3. If `launch` **is not** required for your API, un-check `launch` in the list of body fields in Postman.
9. Confirm that all other values are pre-populated, and that `x-www-form-urlencoded` is checked. 
    - The `grant_type` and `client_assertion_type` values should not change, as they define the token request as a CCG call. The `client_assertion` should also remain the same as it will be populated with the `{{client_assertion}}` collection variable.

## Token request

After configuring the Postman collection, you can generate a client assertion and request an OAuth token. 

1. Select **Lighthouse OAuth Token > POST Client Credentials Example** in the left column of the Postman window.
2. Press the **Send** button, located near the top right of the Postman UI.
3. If all values were configured correctly, you should recieve a JSON object similar to the following example, with an access token and associated metadata:
```json
{
    "access_token": "eyJraWQiOiIzOWdBcj...",
    "token_type": "Bearer",
    "scope": "launch",
    "expires_in": 300,
    "state": null,
    "patient": "1000720100V271387"
}
```
4. You can also view your signed client assertion in the Postman console after making the request. It should look similar to the following example:
```json
client_assertion: eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJodHRwczovL2R
lcHR2YS1ldmFsLm9rdGEuY29tL29hdXRoMi9hdXM4bm0xcTBmN1ZRMGE0ODJwNy92MS90b2tlbiIsI
mlzcyI6IjBvYXUxaWl1eDlUT0RqUU90MnA3Iiwic3ViIjoiMG9hdTFpaXV4OVRPRGpRT3QycDciLCJ
qdGkiOiJiZGFhOGIxNy04ZGVmLTRkOTctOTY3My0xNDlkNjc0NWRlNTAiLCJpYXQiOjE3MTIyNjI4N
TYsImV4cCI6MTcxMjI2MjkxNn0.ikWqX-sRIv5dT1Khs8PWvQ5dMAgUSB_CORB3SHSxWM92hz-QEXM
Z_V6NetnaNRyUvrma-PaQPBrYYs9yOUdP4BvbQgPb_PVjWcHF6QqJuE4UZx-LKNF2sFrrWD5iFqJ0p
1_e9arcv8VSkFaP-IEFJsi22UCffXhDDhawLYJjTBtK0dxZnX1Om_nlortLOfJsKUCnWdyUBS4EKbh
7_ec6ZbP9MrwbO_ssnSMoQfONCwfkH1UdWj-NW41Vb5McNvvW2itwfUU6pD-xRSYQWwm0F0hKlG32C
3PExTfM1xn1uhQBWOURBZ-RhKzx6LaqSHmuaV0BTkwbPTM4GggJcyX06A
```
