# Path to Production for Alpha API Clients

## Background
The Lighthouse program is moving VA towards an Application Programming Interface (API) first driven digital enterprise, which will establish the next generation open management platform for Veterans and accelerate transformation in VA's core functions, such as Health, Benefits, Burial and Memorials. This platform will be a system for designing, developing, publishing, operating, monitoring, analyzing, iterating and optimizing VA’s API ecosystem. 
We are in the alpha stage of the project, wherein we provide one API that enables parties external to the VA to submit of VBA forms and supporting documentation via PDF on behalf of Veterans. 

## Overview 

The Veteran Affairs’ Centralized Mail API allows for the submission of forms and documents to VA for eventual processing by the Veteran Benefits Administration. 

Organizations external to the VA can these submit forms and supporting documentation on behalf of Veterans in PDF format and subsequently check the status of their submission to ensure acceptance and processing in the VA system of record for these forms.  The process described below is specific to the Centralized Mail API and will be updated (with portions automated) for future APIs as VA iterates on this process. 
Authorization
The VA API uses token-based authentication. Clients must provide a token with each HTTP request. This token is issued by the VA. To receive a developer token to access this API in a test environment, please email Alex.Yale-Loehr@va.gov.

## Sample Applications 

Sample code and documentation is available at [https://github.com/department-of-veterans-affairs/vets-api-clients](https://github.com/department-of-veterans-affairs/vets-api-clients). 

## Development API Access
During the alpha phase of this project, if you want access to a development API token, email Alex.Yale-Loehr@va.gov.  We will be creating a self service capability for developer tokens in the near future. 

## Production API Access
During the alpha phase of this project, once you have successfully integrated with the API and are ready to go live, you can request access to a production token by emailing Alex.Yale-Loehr@va.gov, providing the information detailed below. 

### What is the criteria I must meet to be considered for Production API access?
First, you must provide some basic information including:
- Your Name
- Email address
- Website
- Organization name
- Phone number

Next, the following criteria needs to be met and verified by the API team. 

- You are a US based company
- You agree to the Terms of Service
- The VA team is able to verify your information 
- The VA team views a live demo of your application using the API in a test environment and approves of the use case and need for API access


### What happens after I am approved?
You will receive an email from the VA API team notifying you of approval. You will then receive a new Client ID and Secret for your app in production. You will use the base URL api.vets.gov instead of dev-api.vets.gov.

## Developer Guidelines
Below are guidelines you should follow to be successful in your VA API integration.

### Your Privacy Policy
You will be asked to provide a URL to your privacy policy and terms and conditions when applying for production access. These links should be easy to access and understand by a Veteran using your app. Consider using the Model Privacy Notice.

### Rate Limiting and Data Refresh
We implemented basic rate limiting of 60 requests per minute. If you exceed this quota, your request will return a 429 status code.  You may petition for increased rate limits by emailing Alex.Yale-Loehr@va.gov and requests will be decided on a case by case basis.  
 
