# Sandbox Test Accounts for Appeals Status API (v1)

This document provides test user accounts for the [Appeals Status API (v1)](https://developer.va.gov/explore/api/appeals-status/docs?version=current). The API will return synthetic VA records for all test accounts.

**Do not modify any of the attributes for these test accounts, including passwords.** If you need to use one of these accounts for a different use case, [contact us](https://developer.va.gov/support/contact-us) on our developer portal.

## Authentication and Authorization

The authentication model for the [Appeals Status API (v1)](https://developer.va.gov/explore/api/appeals-status/docs?version=current) uses OAuth 2.0/OpenID Connect. The following authorization models are supported:
- [Authorization code flow](https://developer.va.gov/explore/api/appeals-status/authorization-code)
- [Client Credentials Grant (CCG)](https://developer.va.gov/explore/api/appeals-status/client-credentials)

### Logging in with ID.me

To log in to the sandbox environment using ID.me, make sure you:

1. Choose an account that is specific to the scenario you want to test.
2. Select **ID.me** to sign in to the sandbox environment.
3. Enter the ID.me username and password. The password for all ID.me test accounts is: **Password1234!**
4. **Don’t change any preselected answers** when asked about receiving an authentication code. Just click “Continue” to go to the next step.

### Logging in with Login.gov

To log in to the sandbox environment using Login.gov, make sure you:

1. Choose an account that is specific to the scenario you want to test.
2. Select **Login.gov** to sign in to the sandbox environment.
3. Enter the Login.gov username and password. The password for all Login.gov test accounts is: **Password12345!!!**
4. Use the Login.gov MFA seed to generate a 2FA code with an app such as Google Authenticator or Authy.

## Veteran Test Accounts

These accounts can be used to test various data and response scenarios for the `GET /appeals` endpoint. 

`icn` and `X-VA-User` headers are required when making a request. `icn` should match the value in the ICN column, and `X-VA-User` should match the ID.me Username or Login.gov Username (depending on the authentication method used).

| First Name | Last Name | Sandbox Response                                              | ICN               | ID.me Username                 | Login.gov Username        | Login.gov MFA Seed                                                                                                                                                                                              |
|:-----------|:----------|:--------------------------------------------------------------|:------------------|:-------------------------------|:--------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Wesley     | Ford      | 1 Higher Level Review, 1 Supplemental Claim, 2 Legacy Appeals | 1012832025V743496 | va.api.user+idme.025@gmail.com | va.api.user+025@gmail.com | [46OPJSEX7URKZVICEKCARJVV7YRQRLFK](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B025%40gmail.com%29?secret=46OPJSEX7URKZVICEKCARJVV7YRQRLFK) |
| Hector     | Allen     | 1 Higher Level Review, 1 Legacy Appeal                        | 1012667122V019349 | va.api.user+idme.011@gmail.com | va.api.user+011@gmail.com | [GFXLKZNSM3MLI35OP3XKVN4XEUKDIWI5](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B011%40gmail.com%29?secret=GFXLKZNSM3MLI35OP3XKVN4XEUKDIWI5) |
| Janet      | Moore     | 1 Legacy Appeal                                               | 1012861229V078999 | va.api.user+idme.002@gmail.com | va.api.user+002@gmail.com | [B5C3L42PLUWO3U5T](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B002%40gmail.com%29?secret=B5C3L42PLUWO3U5T)                                 |
| Tamara     | Ellis     | 1 Legacy Appeal                                               | 1012667145V762142 | va.api.user+idme.001@gmail.com | va.api.user+001@gmail.com | [LKI7FZ7ZEVRLGQRW](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B001%40gmail.com%29?secret=LKI7FZ7ZEVRLGQRW)                                 |
| Jesse      | Gray      | 0 Appeals                                                     | 1012666073V986297 | va.api.user+idme.004@gmail.com | va.api.user+004@gmail.com | [7OMSKULT5PSVFE3SINTWBT2YA2MSFXU4](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B004%40gmail.com%29?secret=7OMSKULT5PSVFE3SINTWBT2YA2MSFXU4) |
| Pauline    | Foster    | 404 Veteran Not Found                                         | 1012845630V900607 | va.api.user+idme.005@gmail.com | va.api.user+005@gmail.com | [RJIZ4BAI6OIYVKKGYYNHTR7F62IERCDT](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B005%40gmail.com%29?secret=RJIZ4BAI6OIYVKKGYYNHTR7F62IERCDT) |
| Greg       | Anderson  | 500 Internal Server Error                                     | 1012666182V203559 | va.api.user+idme.008@gmail.com | va.api.user+008@gmail.com | [DU5XKE3SS47HHVF62X4C7FASIIAMOSVM](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B008%40gmail.com%29?secret=DU5XKE3SS47HHVF62X4C7FASIIAMOSVM) |