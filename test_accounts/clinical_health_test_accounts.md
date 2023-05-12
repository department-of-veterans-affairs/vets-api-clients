# Clinical Health API Test Accounts in Sandbox

All Health test patients below can be used to test the Clinical Health API in sandbox. A subset of these patients can also be used for testing patient $match, which uses demographic information to find a matching patient in the VA's Master Patient Index (MPI) and returns a patient resource/ICN.

http://build.fhir.org/patient-operation-match.html

Supported resources: MedicationDispense, Condition, MedicationRequest, Observation, Patient, Practitioner.

**Do not modify any of the attributes for these test accounts.** If you need to use one of these accounts for a different use case, [contact us](https://developer.va.gov/support/contact-us) on our developer portal.

**Clinical Health API Test Patients**

| ICN               | First Name | Last Name   | Sex | Birthdate  | Enabled for Patient Match | Address                                        | Phone        |
|:------------------|:-----------|:------------|:----|:-----------|:--------------------------|:-----------------------------------------------|:-------------|
| 32000225          | Sheba703   | Harris789   | F   | 1926-01-08 | ➖️                        | ➖                                              | ➖            |
| 5000335           | Mariano761 | Ruelas156   | M   | 1907-11-20 | ➖️                        | ➖                                              | ➖            |
| 25000126          | Lorenzo669 | Valentín837 | M   | 1942-01-11 | ➖️                        | ➖                                              | ➖            |
| 2000190           | Luis923    | Mayer370    | M   | 1969-07-03 | ➖️                        | ➖                                              | ➖            | 
| 1012853802V084487 | Ruben      | Moreno      | M   | 1949-12-30 | ✔️                        | 12345 Redlands Blvd, San Bernardino, CA, 92346 | 909 555 5555 |
| 1011568236V299349 | One        | Zztest      | M   | 1949-12-30 | ✔️                        | 12345 Redlands Blvd, San Bernardino, CA, 92346 | 909 555 5555 |
| 1012845331V153043 | Judy       | Morrison    | F   | 1945-05-05 | ✔️                        | 4758 Hollowood Way, Murrieta, CA, 92562        | 909 789 6542 |
| 1011548191V178564 | Eleven     | Zztest      | M   | 1945-05-05 | ✔️                        | 4758 Hollowood Way, Murrieta, CA, 92562        | 909 789 6542 |
