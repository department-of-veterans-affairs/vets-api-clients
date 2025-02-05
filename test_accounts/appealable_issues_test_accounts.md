# Sandbox Test Accounts for Appealable Issues API

This document provides test account information for the [Appealable Issues API](https://developer.va.gov/explore/api/appealable-issues/docs?version=current). The API returns synthetic VA records for these test accounts in the sandbox environment.

## Authentication and Authorization

The authentication model for the [Appealable Issues API](https://developer.va.gov/explore/api/appealable-issues/docs?version=current) uses OAuth 2.0/OpenID Connect. The following authorization models are supported:
- [Authorization code flow](https://developer.va.gov/explore/api/appealable-issues/authorization-code)
- [Client Credentials Grant (CCG)](https://developer.va.gov/explore/api/appealable-issues/client-credentials)

**To use this test data**
1. Find the test accounts that meet your use case from the table below.
2. Access login credentials for these accounts and instructions for using ID.me and Login.gov by following the link in the email that was sent to you when you signed up for sandbox access.  If you do not have this email, [request sandbox access](https://developer.va.gov/explore/api/appealable-issues/sandbox-access) on developer.va.gov.
3. We suggest bookmarking both this GitHub page and the page with test data credentials so you can return to them if you need other test accounts. The links to these pages do not expire.

**Do not modify any of the attributes for these test accounts, including passwords.** If you need to use one of these accounts for a different use case, [contact us](https://developer.va.gov/support/contact-us) on our developer portal.

## Veteran Test Accounts

These accounts can be used to test various data and response scenarios for the `GET /appealable-issues/{decisionReviewType}` endpoint. Note that in the sandbox environment, the same results will be returned regardless of the `decisionReviewType` supplied.

An `icn` URL parameter is required when making requests using a representative- or system-scoped token. It is optional when making requests using a veteran-scoped token. If provided, the `icn` parameter value should match the value in the ICN column below.

| Sandbox Response             | ICN               | First Name | Last Name |
|:-----------------------------| :---------------- | :--------- | :-------- |
| Appealable Issues (15)       | 1012832025V743496 | Wesley     | Ford      |
| Appealable Issues (7)        | 1012667122V019349 | Hector     | Allen     |
| Appealable Issues (4)        | 1012861229V078999 | Janet      | Moore     |
| Appealable Issue (1)         | 1012667145V762142 | Tamara     | Ellis     |
| Empty Response               | 1012666073V986297 | Jesse      | Gray      |
| 404 Veteran Record Not Found | 1012845630V900607 | Pauline    | Foster    |
