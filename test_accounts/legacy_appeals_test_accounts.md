# Sandbox Test Accounts for Legacy Appeals API

This document provides test account information for the [Legacy Appeals API](https://developer.va.gov/explore/api/legacy-appeals/docs?version=current). The API returns synthetic VA records for these test accounts in the sandbox environment.

## Authentication and Authorization

The authentication model for the [Legacy Appeals API](https://developer.va.gov/explore/api/legacy-appeals/docs?version=current) uses OAuth 2.0/OpenID Connect. The following authorization models are supported:
- [Authorization code flow](https://developer.va.gov/explore/api/legacy-appeals/authorization-code)
- [Client Credentials Grant (CCG)](https://developer.va.gov/explore/api/legacy-appeals/client-credentials)

Login information for all test accounts can be found on the [developer portal](link-will-go-here-once-page-created).

## Veteran Test Accounts

These accounts can be used to test various data and response scenarios for the `GET /legacy-appeals` endpoint. 

An `icn` parameter is required when making a request. It should match the value in the ICN column.

| Sandbox Response          | ICN               | ID.me Username                 | Login.gov Username        | First Name | Last Name |
| :------------------------ | :---------------- | :----------------------------- | :------------------------ | :--------- | :-------- |
| Legacy Appeals (2)        | 1012832025V743496 | va.api.user+idme.025@gmail.com | va.api.user+025@gmail.com | Wesley     | Ford      |
| Legacy Appeal (1)         | 1012667122V019349 | va.api.user+idme.011@gmail.com | va.api.user+011@gmail.com | Hector     | Allen     |
| Legacy Appeal (1)         | 1012861229V078999 | va.api.user+idme.002@gmail.com | va.api.user+002@gmail.com | Janet      | Moore     |
| Legacy Appeal (1)         | 1012667145V762142 | va.api.user+idme.001@gmail.com | va.api.user+001@gmail.com | Tamara     | Ellis     |
| Empty Response            | 1012666073V986297 | va.api.user+idme.004@gmail.com | va.api.user+004@gmail.com | Jesse      | Gray      |
| 404 Veteran Not Found     | 1012845630V900607 | va.api.user+idme.005@gmail.com | va.api.user+005@gmail.com | Pauline    | Foster    |
| 500 Internal Server Error | 1012666182V203559 | va.api.user+idme.008@gmail.com | va.api.user+008@gmail.com | Greg       | Anderson  |