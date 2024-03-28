# Sandbox Test Accounts for Appeals Status API (v1)

This document provides test account information for the [Appeals Status API (v1)](https://developer.va.gov/explore/api/appeals-status/docs?version=current). The API returns synthetic VA records for these test accounts in the sandbox environment.

## Authentication and Authorization

The authentication model for the [Appeals Status API (v1)](https://developer.va.gov/explore/api/appeals-status/docs?version=current) uses OAuth 2.0/OpenID Connect. The following authorization models are supported:
- [Authorization code flow](https://developer.va.gov/explore/api/appeals-status/authorization-code)
- [Client Credentials Grant (CCG)](https://developer.va.gov/explore/api/appeals-status/client-credentials)

**To use this test data**
1. Find the test accounts that meet your use case from the table below.
2. Access login credentials for these accounts and instructions for using ID.me and Login.gov by following the link in the email that was sent to you when you signed up for sandbox access.  If you do not have this email, [request sandbox access](https://developer.va.gov/support/contact-us) on developer.va.gov.
3. We suggest bookmarking both this GitHub page and the page with test data credentials so you can return to them if you need other test accounts. The links to these pages do not expire.

**Do not modify any of the attributes for these test accounts, including passwords.** If you need to use one of these accounts for a different use case, [contact us](https://developer.va.gov/support/contact-us) on our developer portal.

## Veteran Test Accounts

These accounts can be used to test various data and response scenarios for the `GET /appeals` endpoint. 

An `icn` parameter and an `X-VA-User` header are required when making a request. The `icn` should match the value in the ICN column below, and the `X-VA-User` should match the test account's ID.me or Login.gov username (depending on the authentication method used) from the link provided when you signed up for sandbox access.

| Sandbox Response                                                    | ICN               | First Name | Last Name |
|:--------------------------------------------------------------------|:------------------|:-----------|:----------|
| Higher Level Review (1), Supplemental Claim (1), Legacy Appeals (2) | 1012832025V743496 | Wesley     | Ford      |
| Higher Level Review (1), Legacy Appeal (1)                          | 1012667122V019349 | Hector     | Allen     |
| Legacy Appeal (1)                                                   | 1012861229V078999 | Janet      | Moore     |
| Legacy Appeal (1)                                                   | 1012667145V762142 | Tamara     | Ellis     |
| Empty Response                                                      | 1012666073V986297 | Jesse      | Gray      |
| 404 Veteran Not Found                                               | 1012845630V900607 | Pauline    | Foster    |
| 500 Internal Server Error                                           | 1012666182V203559 | Greg       | Anderson  |