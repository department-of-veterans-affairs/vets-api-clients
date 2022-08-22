# Sandbox Test Accounts for Direct Deposit Management API

These test users have a variety of synthetic VA records such as service history and disability rating attached to them and can be used to test the [Direct Deposit Management API](https://github.com/department-of-veterans-affairs/lighthouse-direct-deposit-management).
Note: Just because the GET endpoint is a happy path and says EFT is updatable, the PUT endpoint may have an error.

| First Name | Middle Name | Last Name       | ICN               | GET Endpoint Behavior                                                                                                                              | PUT Endpoint Behavior                                                                                                          |
|:-----------|:------------|:----------------|:------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Jesse      |             | Gray            | 1012666073V986297 | Happy Path - Can Update                                                                                                                            | Happy Path - Able to Update - 200 OK                                                                                           |
| Pauline    | Null        | Foster          | 1012845630V900607 | Happy Path - Can Update                                                                                                                            | Happy Path - Able to Update - 200 OK                                                                                           |
| Ben        | E           | Weaver          | 1012848404V121721 | Valid Response - But Cannot Update - mailingAddressExistIndicator and paymentAddressIndicator are false.                                           | 400 Bad Request - "Updating bank information not allowed."                                                                     |
| Greg       | A           | Anderson        | 1012666182V203559 | Happy Path - Can Update                                                                                                                            | Happy Path - Able to Update - 200 OK                                                                                           |
| Kyle       | M           | Cole            | 1012830774V793840 | Valid Response - But Cannot Update - paymentAddressIndicator is false.                                                                             | 400 Bad Request - "Updating bank information not allowed."                                                                     |
| Norman     | SHOPAY      | Mills           | 1012845642V923610 | Happy Path - Can Update                                                                                                                            | 400 Bad Request - "Update Failed: Potential address issue." - Failed because of address issue on backend system during update. |
| Tamara     | E           | Ellis           | 1012667145V762142 | Happy Path - Can Update                                                                                                                            | Happy Path - Able to Update - 200 OK                                                                                           |
| Timothy    | HOO         | Soto            | 1012833438V267437 | Happy Path - Can Update                                                                                                                            | Happy Path - Able to Update - 200 OK                                                                                           |
| James      | M           | Beck            | 1012643432V477452 | Valid Response - But Cannot Update - indentityIndicator, indexIndicator, mailingAddressExistIndicator, and noFiduciaryAssignedIndicator are false. | 400 Bad Request - "Updating bank information not allowed."                                                                     |
| Travis     | Null        | Jones           | 1012845638V677813 | Valid Response - But Cannot Update - noBdnPaymentsIndicator is false.                                                                              | 400 Bad Request - "Updating bank information not allowed."                                                                     |
| Ruth       | Vereen      | Vereen(Spencer) | 1012845697V367266 | Happy Path - Can Update                                                                                                                            | 400 Bad Request - "Update Failed: Routing number related to potential fraud"                                                   |
| Oscar      | F           | Jones           | 1012666047V544942 | Happy Path - Can Update                                                                                                                            | 400 Bad Request - "Update Failed: Flashes on record. Routing number related to potential fraud."                               |
| Julio      | George      | Henderson       | 1012829610V986182 | Happy Path - Can Update                                                                                                                            | Happy Path - Able to Update - 200 OK                                                                                           |
| Johnnie    | Leonard     | Weaver          | 1012740600V714187 | Happy Path - Can Update                                                                                                                            | 400 Bad Request - "Update Failed: GUIE50022"                                                                                   |
| Dale       | P           | Soto JR         | 1012833451V763238 | Happy Path - Can Update                                                                                                                            | Happy Path - Able to Update - 200 OK                                                                                           |
| Christian  | Darnell     | Turner          | 1012830899V368969 | Happy Path - Can Update                                                                                                                            | Happy Path - Able to Update - 200 OK                                                                                           |
| Brian      | Null        | Lawrence        | 1012845191V379613 | Happy Path - Can Update                                                                                                                            | 400 Bad Request - "Update Failed: Invalid Routing Number"                                                                      |
| Allan      | Null        | Butler          | 1012829948V217207 | Valid Response - But Cannot Update - noBdnPaymentsIndicator is false.                                                                              | 400 Bad Request - "Updating bank information not allowed."                                                                     |