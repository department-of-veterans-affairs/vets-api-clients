# Postman CCG Pre-request Script

## Description:

This Postman collection contains pre-script request methods for VA API's using CCG OAuth. It generates a JWT assertion, requests an OAuth access token, and shows an example call interacting with the Patient Health API.

## Configuration:

1. Import "CCG Pre-request Script.postman_collection.json" into your Postman workspace.

2. Click on “CCG Pre-request Script” in the left column of Postman, to view the collection tabs for "CCG Pre-request Script".

3. Click on "Varaibles" within Postman, to view pre set collection variables.

4. Configure "CCG Pre-request Script" collection variables (aud, tokenUrl, clientId, privatePem, scope, launch) in Postman, assigning them their respective values. Follow the guidance provided at https://developer.va.gov/explore/api/patient-health/client-credentials to obtain the necessary collection variable values for the Patient Health API. For other APIs, consult the Lighthouse CCG API page related to your desired interaction for accurate API-specific collection variable values.

a. aud (Collection variable)
Example Patient Health API aud value:
https://deptva-eval.okta.com/oauth2/aus8nm1q0f7VQ0a482p7/v1/token

b. tokenUrl (Collection variable)
Example Patient Health API tokenUrl value:
https://sandbox-api.va.gov/oauth2/health/system/v1/token

c. clientId (Collection variable)
Example clientId value:
Your CCG clientId

d. privatePem (Collection variable)
Example privatePem value:
-----BEGIN RSA PRIVATE KEY-----
Your private pem
-----END RSA PRIVATE KEY-----

e. scope (Collection variable)
Example Patient Health API scope value:
launch system/AllergyIntolerance.read system/Appointment.read system/Condition.read system/Coverage.read system/Coverage.write system/DiagnosticReport.read system/Immunization.read system/Location.read system/Medication.read system/MedicationOrder.read system/Observation.read system/Organization.read system/Patient.read

f. launch (Collection variable)
Example Patient Health API launch value:
eyJwYXRpZW50IjoiMTIzNDUifQ==

## Run:

This step generates a JWT assertion, requests an OAuth access token, and shows an example call interacting with the Lighthouse API of choice. Users can view the JWT assertion and the OAuth access token in the console after running "ccg-api-request".

1. Click on “ccg-api-request” in the left column of Postman (under the CCG Pre-request Script Collection). The pre-configured HTTP call will appear.

2. Click "Send".

## Note:

Ensure that you have valid values for the collection variables, as incorrect or missing values may result in issues.