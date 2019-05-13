# VBA Document Upload Service

Sample clients and API documentation for the VBA document upload service.

**This service is a work-in-progress and is currently only available in a 
development environment. Data submitted through the development endpoint 
will not be processed by VA.**

## Overview

This service allows for the submission of forms and documents to VA for 
eventual processing by the Veteran Benefits Administration. Clients can 
submit forms and supporting documentation in PDF format, and subsequently
check the status of their submission to ensure acceptance and processing in
the VA system of record for these forms.

## API Specification
- [PDF](https://github.com/department-of-veterans-affairs/vets-api-clients/blob/master/services/vba_documents/Document%20Upload%20API%20Design.pdf)

## API Endpoints
- (Pending)

## Sample Clients
- [Bash/cURL](curl)

## Current Limitations
- This service is a work-in-progress and is currently only available in a
development environment. Data submitted through the development endpoint
will not be processed by VA.

- The status of forms submitted to the dev-api.vets.gov endpoint will only
progress to the `received` status, not to `processed` or `success`.
