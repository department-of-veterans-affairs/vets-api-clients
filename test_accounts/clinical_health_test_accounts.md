# Clinical Health API Test Accounts in Sandbox

All Health test patients below can be used to test the Clinical Health API in sandbox. A subset of these patients can also be used for testing patient $match, which uses demographic information to find a matching patient in the VA's Master Patient Index (MPI) and returns a patient resource/ICN.

https://hl7.org/fhir/r4/patient-operation-match.html

Supported resources: AllergyIntolerance, MedicationDispense, Condition, MedicationRequest, Observation, Patient, Practitioner.

**Do not modify any of the attributes for these test accounts.** If you need to use one of these accounts for a different use case, [contact us](https://developer.va.gov/support/contact-us) on our developer portal.

**Clinical Health API Test Patients**

| Id  | ICN               | First Name | Last Name   | Sex | Birthdate  | Enabled for Patient Match    | Address                                                | Phone        |
|-----|-------------------|------------|-------------|-----|------------|------------------------------|--------------------------------------------------------|--------------|
| 101 | 32000225          | Sheba703   | Harris789   | F   | 1926-01-08 | false                        | 1074 McGlynn Wynd Apt 72, Buffalo, NY, 14201           | 555 436 2634 |
| 102 | 5000335           | Mariano761 | Ruelas156   | M   | 1907-11-20 | false                        | 245 Padberg Quay Suite 99, Colorado Springs, CO, 80809 | 555 309 5927 |
| 103 | 25000126          | Lorenzo669 | Valentín837 | M   | 1942-01-11 | false                        | 242 Legros Walk, Ballwin, MO, 63005                    | 555 933 3641 |
| 114 | 2000190           | Luis923    | Mayer370    | M   | 1969-07-03 | false                        | 948 Paucek Well, Phoenix, AZ, 85003                    | 555 171 5011 |
|     | 1012853802V084487 | Ruben      | Moreno      | M   | 1949-12-30 | true                         | 12345 Redlands Blvd, San Bernardino, CA, 92346         | 909 555 5555 |
|     | 1011568236V299349 | One        | Zztest      | M   | 1949-12-30 | true                         | 12345 Redlands Blvd, San Bernardino, CA, 92346         | 909 555 5555 |
|     | 1012845331V153043 | Judy       | Morrison    | F   | 1945-05-05 | true                         | 4758 Hollowood Way, Murrieta, CA, 92562                | 909 789 6542 |
|     | 1011548191V178564 | Eleven     | Zztest      | M   | 1945-05-05 | true                         | 4758 Hollowood Way, Murrieta, CA, 92562                | 909 789 6542 |

