# Sandbox Test Accounts for Health APIs

**Veteran Health** test users have a variety of synthetic health records attached to them and can be used to test the [Veteran Health API](https://developer.va.gov/explore/health/docs/fhir?version=current). A small subset of these users can also be used for testing the [Clinical Health API](https://developer.va.gov/explore/health/docs/clinical_health?version=current).

**Do not modify any of the attributes for these test accounts, including passwords.** If you need to use one of these accounts for a different use case, [contact us](https://developer.va.gov/support/contact-us) on our developer portal.

## Logging in with ID.me

To log in to the sandbox environment using ID.me, make sure you:

  1. Choose an account that is specific to the API you want to test.
  2. Select **ID.me** to sign in to the sandbox environment.
  3. Enter the ID.me username and password. The password for all ID.me test accounts is: **Password1234!**
  4. **Don’t change any preselected answers** when asked about receiving an authentication code. Just click “Continue” to go to the next step.

## Logging in with Login.gov

To log in to the sandbox environment using Login.gov, make sure you:

  1. Choose an account that is specific to the API you want to test.
  2. Select **Login.gov** to sign in to the sandbox environment.
  3. Enter the Login.gov username and password. The password for all Login.gov test accounts is: **Password12345!!!**
  4. Use the Login.gov MFA seed to generate a 2FA code with an app such as Google Authenticator or Authy.

## Veteran Account Information
**Password for all ID.me accounts: Password1234!**
**Password for all Login.gov accounts: Password12345!!!**
**NOTE:**

 * Details about Conditions associated with a patient can be found in [Test Patient Conditions](https://github.com/department-of-veterans-affairs/vets-api-clients/blob/ramosan-add-patient-conditions/test_accounts/health_test_account_conditions.xlsx).
 * Details about patients with COVID-19 related test data can be found [below](#covid19-test-data).

| ICN      | First Name   | Last Name      | Sex  | Birthdate  | Clinical Health API | ID.me Username                 | Login.gov Username             | Login.gov MFA Seed               |
| :---     | :---         | :---           | :--- | :---       | :---                | :---                           | :---                           | :---                             |
| 32000225 | Sheba703     | Harris789      | F    | 1926-01-08 | ✔️                   | va.api.user+idme.101@gmail.com | va.api.user+101@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 5000335  | Mariano761   | Ruelas156      | M    | 1907-11-20 | ✔️                   | va.api.user+idme.102@gmail.com | va.api.user+102@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 25000126 | Lorenzo669   | Valentín837    | M    | 1942-01-11 | ✔️                   | va.api.user+idme.103@gmail.com | va.api.user+103@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 25000285 | Porfirio146  | Schmeler639    | M    | 1916-06-15 | ➖                   | va.api.user+idme.104@gmail.com | va.api.user+104@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 32000551 | Moshe758     | Windler79      | M    | 1917-03-05 | ➖                   | va.api.user+idme.105@gmail.com | va.api.user+105@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 36000216 | Wayne846     | Goyette777     | M    | 1947-05-30 | ➖                   | va.api.user+idme.106@gmail.com | va.api.user+106@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 36000036 | Ned189       | Renner328      | M    | 1993-09-06 | ➖                   | va.api.user+idme.107@gmail.com | va.api.user+107@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 39000049 | Harvey63     | Kuhic920       | M    | 1927-10-21 | ➖                   | va.api.user+idme.108@gmail.com | va.api.user+108@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 40000200 | Jewell855    | Bergstrom287   | M    | 1945-10-19 | ➖                   | va.api.user+idme.109@gmail.com | va.api.user+109@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 40000153 | Bryan958     | Ferry570       | M    | 1939-01-24 | ➖                   | va.api.user+idme.110@gmail.com | va.api.user+110@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 42000354 | Gilberto712  | Iglesias873    | M    | 1926-04-05 | ➖                   | va.api.user+idme.111@gmail.com | va.api.user+111@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 42000256 | Al123        | Rohan584       | M    | 1996-12-07 | ➖                   | va.api.user+idme.112@gmail.com | va.api.user+112@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 30000207 | Chadwick722  | Hermann103     | M    | 1947-07-31 | ➖                   | va.api.user+idme.113@gmail.com | va.api.user+113@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 2000190  | Luis923      | Mayer370       | M    | 1969-07-03 | ➖                   | va.api.user+idme.114@gmail.com | va.api.user+114@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 2000163  | Aurelio227   | Cruickshank494 | M    | 1995-02-06 | ➖                   | va.api.user+idme.115@gmail.com | va.api.user+115@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 2000167  | Jefferey580  | Terry864       | M    | 1957-03-11 | ➖                   | va.api.user+idme.116@gmail.com | va.api.user+116@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 23000219 | Taylor21     | Mann644        |      |            | ➖                   | va.api.user+idme.117@gmail.com | va.api.user+117@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 35000422 | Julius90     | Gutmann970     | M    | 1947-11-13 | ➖                   | va.api.user+idme.118@gmail.com | va.api.user+118@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43000199 | Carlita746   | Kautzer186     | F    | 1998-01-27 | ➖                   | va.api.user+idme.119@gmail.com | va.api.user+119@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43000482 | Herb645      | Reilly981      | M    | 1993-10-14 | ➖                   | va.api.user+idme.120@gmail.com | va.api.user+120@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43000466 | Emmaline88   | Considine820   | F    | 1914-03-08 | ➖                   | va.api.user+idme.121@gmail.com | va.api.user+121@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43001199 | Gerardo48    | Leal292        | M    | 1944-01-21 | ➖                   | va.api.user+idme.122@gmail.com | va.api.user+122@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43000334 | Boris111     | Keebler762     | M    | 1939-08-25 | ➖                   | va.api.user+idme.123@gmail.com | va.api.user+123@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43000341 | Vicente970   | Mata817        | M    | 1919-01-11 | ➖                   | va.api.user+idme.124@gmail.com | va.api.user+124@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43000807 | Danilo179    | Quigley282     | M    | 1992-01-25 | ➖                   | va.api.user+idme.125@gmail.com | va.api.user+125@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43000811 | Kendrick479  | McCullough561  | M    | 1992-01-25 | ➖                   | va.api.user+idme.126@gmail.com | va.api.user+126@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 18000027 | Jarrett354   | Bednar518      | M    | 1908-10-09 | ➖                   | va.api.user+idme.127@gmail.com | va.api.user+127@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 43000498 | Alex454      | Kris249        | F    | 1940-11-11 | ➖                   | va.api.user+idme.128@gmail.com | va.api.user+128@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 9        | Titus37      | Mosciski958    | M    | 1942-04-15 | ➖                   | va.api.user+idme.129@gmail.com | va.api.user+129@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 32       | Ricardo560   | Bechtelar572   | M    | 1935-11-14 | ➖                   | va.api.user+idme.130@gmail.com | va.api.user+130@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 260      | Miguel815    | Vela532        | M    | 1983-08-10 | ➖                   | va.api.user+idme.131@gmail.com | va.api.user+131@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 25       | Cletus494    | Walsh511       | M    | 1937-07-19 | ➖                   | va.api.user+idme.132@gmail.com | va.api.user+132@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 44       | Mariano761   | Stark857       | M    | 1913-02-01 | ➖                   | va.api.user+idme.133@gmail.com | va.api.user+133@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 17       | Lorenzo669   | Bartell116     | M    | 1961-04-27 | ➖                   | va.api.user+idme.134@gmail.com | va.api.user+134@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 23       | Renaldo199   | Runte676       | M    | 1968-12-09 | ➖                   | va.api.user+idme.135@gmail.com | va.api.user+135@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 41       | Art115       | Lang846        | M    | 1947-04-24 | ➖                   | va.api.user+idme.136@gmail.com | va.api.user+136@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 49       | Hai304       | Walter473      | M    | 1950-11-26 | ➖                   | va.api.user+idme.137@gmail.com | va.api.user+137@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 160      | Ollie731     | Abernathy524   | M    | 1970-11-10 | ➖                   | va.api.user+idme.138@gmail.com | va.api.user+138@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 173      | Tyler508     | Schaden604     | M    | 1987-10-03 | ➖                   | va.api.user+idme.139@gmail.com | va.api.user+139@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 195      | Dan465       | Brekke496      | M    | 1987-01-29 | ➖                   | va.api.user+idme.140@gmail.com | va.api.user+140@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 29       | Elmer371     | Kiehn525       | M    | 1935-11-23 | ➖                   | va.api.user+idme.141@gmail.com | va.api.user+141@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 39       | Marcelino726 | Nader710       | M    | 1923-08-28 | ➖                   | va.api.user+idme.142@gmail.com | va.api.user+142@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 59       | Rebecca981   | Barrows492     | F    | 1962-11-08 | ➖                   | va.api.user+idme.143@gmail.com | va.api.user+143@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 38       | Darryl392    | Hartmann983    | M    | 1945-04-18 | ➖                   | va.api.user+idme.144@gmail.com | va.api.user+144@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 297      | Lavern240    | Hickle134      | M    | 1910-09-14 | ➖                   | va.api.user+idme.145@gmail.com | va.api.user+145@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 48       | Damian46     | McKenzie376    | M    | 1963-04-29 | ➖                   | va.api.user+idme.146@gmail.com | va.api.user+146@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 42       | Vance413     | Mosciski958    | M    | 1960-12-13 | ➖                   | va.api.user+idme.147@gmail.com | va.api.user+147@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 129      | Hoyt490      | Fritsch593     | M    | 1976-03-24 | ➖                   | va.api.user+idme.148@gmail.com | va.api.user+148@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 1000003  | Tobias236    | Wolff180       | M    | 1970-11-14 | ➖                   | va.api.user+idme.149@gmail.com | va.api.user+149@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 1000005  | Shane235     | Bartell116     | M    | 1958-11-10 | ➖                   | va.api.user+idme.150@gmail.com | va.api.user+150@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 1000031  | Jc393        | Batz141        | M    | 1975-09-06 | ➖                   | va.api.user+idme.151@gmail.com | va.api.user+151@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 9000508  | Emery884     | Stroman228     | M    | 1913-06-06 | ➖                   | va.api.user+idme.152@gmail.com | va.api.user+152@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 9000682  | Florentino8  | Raynor401      | M    | 1950-04-06 | ➖                   | va.api.user+idme.153@gmail.com | va.api.user+153@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 9000777  | Alvaro283    | Roberts511     | M    | 1935-08-02 | ➖                   | va.api.user+idme.154@gmail.com | va.api.user+154@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 9000756  | Derrick232   | Greenfelder433 | M    | 1947-12-17 | ➖                   | va.api.user+idme.155@gmail.com | va.api.user+155@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 9000598  | Jon665       | Terry864       | M    | 1984-11-02 | ➖                   | va.api.user+idme.156@gmail.com | va.api.user+156@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 10000271 | Cornelius968 | Buckridge80    | M    | 1920-06-29 | ➖                   | va.api.user+idme.157@gmail.com | va.api.user+157@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 38000186 | Elias404     | Olson653       | M    | 1918-01-01 | ➖                   | va.api.user+idme.158@gmail.com | va.api.user+158@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 38000008 | Ethan766     | Auer97         | M    | 1986-07-09 | ➖                   | va.api.user+idme.159@gmail.com | va.api.user+159@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 38000227 | Raymundo71   | Barrows492     | M    | 1997-06-21 | ➖                   | va.api.user+idme.160@gmail.com | va.api.user+160@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 38000035 | Chet188      | Sanford861     | M    | 1928-04-17 | ➖                   | va.api.user+idme.161@gmail.com | va.api.user+161@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 38000527 | Nicholas495  | Lueilwitz711   | M    | 1919-02-04 | ➖                   | va.api.user+idme.162@gmail.com | va.api.user+162@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 38000646 | Silas208     | Little434      | M    | 1924-07-29 | ➖                   | va.api.user+idme.163@gmail.com | va.api.user+163@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 13000493 | Douglas31    | Dietrich576    | M    | 1914-06-11 | ➖                   | va.api.user+idme.164@gmail.com | va.api.user+164@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 28000131 | Geraldo282   | Haag279        | M    | 1996-10-07 | ➖                   | va.api.user+idme.165@gmail.com | va.api.user+165@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 48000087 | Melvin857    | Bartoletti50   | M    | 1995-06-24 | ➖                   | va.api.user+idme.166@gmail.com | va.api.user+166@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 17000098 | Freeman822   | Prohaska837    | M    | 1915-05-08 | ➖                   | va.api.user+idme.167@gmail.com | va.api.user+167@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 17000024 | Gino587      | Herman763      | M    | 1936-10-09 | ➖                   | va.api.user+idme.168@gmail.com | va.api.user+168@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 17000151 | Jasper743    | Gorczany269    | M    | 1976-09-08 | ➖                   | va.api.user+idme.169@gmail.com | va.api.user+169@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 21000265 | Alonso270    | Jacobson885    | M    | 1935-07-06 | ➖                   | va.api.user+idme.170@gmail.com | va.api.user+170@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 21000177 | Anibal473    | Cronin387      | M    | 1916-12-02 | ➖                   | va.api.user+idme.171@gmail.com | va.api.user+171@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 4001192  | Stevie682    | Gerhold939     | M    | 1948-02-17 | ➖                   | va.api.user+idme.172@gmail.com | va.api.user+172@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 4000399  | Andres25     | Wintheiser220  | M    | 1941-05-01 | ➖                   | va.api.user+idme.173@gmail.com | va.api.user+173@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 4000751  | Dante562     | Hayes766       | M    | 1909-08-01 | ➖                   | va.api.user+idme.174@gmail.com | va.api.user+174@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 46000380 | Pasquale620  | Aufderhar910   | M    | 1931-03-25 | ➖                   | va.api.user+idme.175@gmail.com | va.api.user+175@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 46000560 | Alonso270    | Schultz619     | M    | 1922-01-10 | ➖                   | va.api.user+idme.176@gmail.com | va.api.user+176@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 46000180 | Emilio417    | Hirthe744      | M    | 1961-06-17 | ➖                   | va.api.user+idme.177@gmail.com | va.api.user+177@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 37000071 | Foster87     | Williamson769  | M    | 1938-08-11 | ➖                   | va.api.user+idme.178@gmail.com | va.api.user+178@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 37000195 | Charley358   | O'Kon634       | M    | 1992-08-17 | ➖                   | va.api.user+idme.179@gmail.com | va.api.user+179@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 47000002 | Drew592      | Hegmann834     | M    | 1981-07-09 | ➖                   | va.api.user+idme.180@gmail.com | va.api.user+180@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 47000043 | Forrest301   | Miller503      | M    | 1978-09-26 | ➖                   | va.api.user+idme.181@gmail.com | va.api.user+181@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 47000145 | Ward668      | Cronin387      | M    | 1939-03-04 | ➖                   | va.api.user+idme.182@gmail.com | va.api.user+182@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 47000289 | Reynaldo722  | Simonis280     | M    | 1909-04-04 | ➖                   | va.api.user+idme.183@gmail.com | va.api.user+183@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |

## Covid19 Test Data

| ICN      | Immunization               | Covid Lab Tests | ID.me Username                 | Login.gov Username        | Login.gov MFA Seed               |
| :---     | :---                       | :---            | :---                           | :---                      | :---                             |
| 43000199 | None                       | Positive        | va.api.user+idme.119@gmail.com | va.api.user+119@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 9000682  | 2 doses of Moderna         | Positive        | va.api.user+idme.153@gmail.com | va.api.user+153@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 9000756  | Only first dose of Moderna | Negative        | va.api.user+idme.155@gmail.com | va.api.user+155@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
| 4001192  | 2 doses of Pfizer          | Positive        | va.api.user+idme.172@gmail.com | va.api.user+172@gmail.com | TODOAVD3MUOWJEENIS2FTJZEAROTGBAC |
