# Path to Production for API Clients

## Background
The Lighthouse program is moving VA towards an Application Programming Interface (API) first driven digital enterprise, which will establish the next generation open management platform for Veterans and accelerate transformation in VA's core functions, such as Health, Benefits, Burial and Memorials. This platform will be a system for designing, developing, publishing, operating, monitoring, analyzing, iterating and optimizing VA’s API ecosystem. 

## Overview 

The VA API uses token-based authentication. Clients must provide a token with each HTTPS request. This token is issued by the VA. 

## Development API Access
To receive a developer token to access an API in a test environment, go to https://developer.va.gov/apply.  If you are having trouble using https://developer.va.gov/apply or have questions, email api@va.gov and we will get back to you quickly!

## Production API Access
Once you have successfully integrated with the API and are ready to go live, you can request access to a production token by emailing api@va.gov, providing the information detailed below. 

### What is the criteria I must meet to be considered for Production API access?
First, you must provide some basic information including:
- Your Name
- Email address
- Website
- Organization name
- Phone number

Next, the following criteria needs to be met and verified by the API team. 

- You are a US based company
- You agree to the [Terms of Service](https://developer.va.gov/explore/terms-of-service)
- The VA team is able to verify your information 
- The VA team views a live demo of your application using the API in a test environment and approves of the use case and need for API access

### What happens after I send an email requesting production access?
We will set up a meeting with you and the VA teams accounable for the API you want to use in production to get a demo of the application, answer technical questions about your implementation, and to ensure everyone understands the use case, implementation, and expected usage and is prepared to move forward. 

### What happens after I am approved?
You will receive an email from the VA API team notifying you of approval. You will then receive a new Client ID and Secret for your app in production. You will use the base URL api.va.gov instead of dev-api.va.gov.

## Developer Guidelines
Below are guidelines you should follow to be successful in your VA API integration.

### Your Privacy Policy
If you are a team external to VA, you will be asked to provide a URL to your privacy policy and terms and conditions when applying for production access. These links should be easy to access and understand by a Veteran using your application. 

### Rate Limiting and Data Refresh
We implemented basic rate limiting of 60 requests per minute. If you exceed this quota, your request will return a 429 status code.  You may petition for increased rate limits by emailing api@va.gov and requests will be decided on a case by case basis. 
