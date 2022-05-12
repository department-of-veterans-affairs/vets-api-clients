# Sandbox Test Accounts for VA Letter Generator API

These test users have a variety of synthetic VA records such as service history and disability rating attached to them and can be used to test the [VA Letter Generator API](LINK_TO_LETTER_GENERATOR_DOCS).

**Do not modify any of the attributes for these test accounts, including passwords.** If you need to use one of these accounts for a different use case, [contact us](https://developer.va.gov/support/contact-us) on our developer portal.

## Logging in with ID.me

To log in to the sandbox environment using ID.me, make sure you:

1. Choose an account that is specific to the API you want to test.
2. Select **ID.me** to sign in to the sandbox environment.
3. Enter the ID.me username and password. The password for all ID.me test accounts is: **Password1234!**
4. **Don’t change any preselected answers** when asked about receiving an authentication code. Just click “Continue” to go to the next step.

## Logging in with Login.gov

To log in to the sandbox environment using Login.gov, make sure you:

1. Choose an account that is specific to the API you want to test.
2. Select **Login.gov** to sign in to the sandbox environment.
3. Enter the Login.gov username and password. The password for all Login.gov test accounts is: **Password12345!!!**
4. Use the Login.gov MFA seed to generate a 2FA code with an app such as Google Authenticator or Authy.

## Veteran Account Information regarding VA Letters

**Password for all ID.me accounts: Password1234!**

**Password for all Login.gov accounts: Password12345!!!**

| First Name | Middle Name | Last Name | ICN               | Eligible Letters                                                                                                                                      | Expected Errors                                                                                                                                                      | ID.me Username                 | Login.gov Username       | Login.gov MFA Seed                                                                                                                                                                                              |
|:----------|:------------|:----------|:------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------|:-------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Jesse     |             | Gray      | 1012666073V986297 | Benefit Summary, Benefit Verification, Civil Service, Commissary, Medicare Part D, Minimum Essential Coverage, Proof of Service, Service Verification | None                                                                                                                                                                 | va.api.user+idme.004@gmail.com | va.api.user+004@gmail.com | [7OMSKULT5PSVFE3SINTWBT2YA2MSFXU4](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B004%40gmail.com%29?secret=7OMSKULT5PSVFE3SINTWBT2YA2MSFXU4) |
| Pauline   | Null        | Foster    | 1012845630V900607 | Benefit Summary, Benefit Verification, Civil Service, Proof of Service, Service Verification                                                          | Benefit Verification: 422 Missing Required Data - activeAwardLine missing from BGSOtherInfo.                                                                         | va.api.user+idme.005@gmail.com | va.api.user+005@gmail.com | [RJIZ4BAI6OIYVKKGYYNHTR7F62IERCDT](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B005%40gmail.com%29?secret=RJIZ4BAI6OIYVKKGYYNHTR7F62IERCDT) |
| Ben       | E           | Weaver    | 1012848404V121721 |                                                                                                                                                       | Messages on the eligibility check noting that eligibility could not be determined - Does not have participantId from MPI. Does not have VIERS or VA Profile records. |                                |                          |  |
| Greg      | A           | Anderson  | 1012666182V203559 |                                                                                                                                                       | Messages on the eligibility check noting that eligibility could not be determined - Does not have VIERS or VA Profile records.                                       | va.api.user+idme.008@gmail.com | va.api.user+008@gmail.com | [DU5XKE3SS47HHVF62X4C7FASIIAMOSVM](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B008%40gmail.com%29?secret=DU5XKE3SS47HHVF62X4C7FASIIAMOSVM) |
| Kyle      | M           | Cole      | 1012830774V793840 |                                                                                                                                                       |                                                                                                                                                                      | va.api.user+idme.021@gmail.com |                          |                                                                                                                                                                                                                 |
| Norman    | SHOPAY      | Mills     | 1012845642V923610 | Benefit Summary, Civil Service, Proof of Service, Service Verification                                                                                |                                                                                                                                                                      |                                |                          |                                                                                                                                                                                                                 |
| Tamara    | E           | Ellis     | 1012667145V762142 | Medicare Part D, Minimum Essential Coverage                                                                                                           | All eligible letters: 422 Missing Required Data - Missing Address                                                                                                    | va.api.user+idme.001@gmail.com | va.api.user+001@gmail.com | [LKI7FZ7ZEVRLGQRW](https://chart.googleapis.com/chart?chs=200x200&chld=M%7C0&cht=qr&chl=otpauth://totp/Login.gov%20%28va.api.user%2B001%40gmail.com%29?secret=LKI7FZ7ZEVRLGQRW) |
| Timothy   | HOO         | Soto      | 1012833438V267437 | Benefit Summary, Benefit Verification, Civil Service, Proof of Service, Service Verification                                                          | All eligible letters: 422 Missing Required Data - Missing ZipCode5                                                                                                   |                                |                          |                                                                                                                                                                                                                 |
