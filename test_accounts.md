# VA Lighthouse OAuth Test User Accounts

These are test accounts you can use to test OAuth APIs by logging in with them through the ID.me sandbox environment that is connected to sandbox-api.va.gov.  When signing in with a test account, Step 2 will ask how you want to receive an authentication code and you can just click "continue" for the verification to be automatically populated in Step 3.

## Representative Oauth

The purpose behind Representative Oauth is to allow you to login as one of 3 types of users (VSO, Attorney or Claim Agent) who holds power of attorney (PoA) for a particular veteran through the Oauth and ID.me system and then user the token you've collected to essentially access that Veteran's data (currently only available in our [Claims V1 API's](https://developer.va.gov/explore/benefits/docs/claims?version=current)), this process involves us looking at which Office of General Counsel (OGC) PoA code the veteran has and matching it to the PoA code the Representative is authorized to access. Example of a Representatie curl command is provided below.

```
curl -X GET \
  https://sandbox-api.va.gov/services/claims/v1/claims \
  -H 'Authorization: Bearer {token}' \
  -H 'X-VA-Birth-Date: 1967-06-19' \
  -H 'X-VA-First-Name: Tamara' \
  -H 'X-VA-Last-Name: Ellis' \
  -H 'X-VA-SSN: 796130115' \
  -H 'cache-control: no-cache'

```

**Do not modify any of the attributes for these test accounts, including passwords.** 

| First Name | Middle Name | Last Name | Sex | Birthdate  | SSN       | Email                          | Password      | Representative                | Branch (Discharge) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| TAMARA     | E           | ELLIS     | F | 1967-06-19 | 796130115 | va.api.user+idme.001@gmail.com | Password1234! | va.api.user+idme.007@gmail.com | Army (Honorable) |
| JANET      | L           | MOORE     | F | 1949-05-06 | 796127677 | va.api.user+idme.002@gmail.com | Password1234! | | Navy (Honorable) |
| RALPH      | E           | LEE       | M | 1948-10-30 | 796378782 | va.api.user+idme.003@gmail.com | Password1234! | va.api.user+idme.007@gmail.com | Marines (Dishonorable) |
| JESSE      |             | GRAY      | M | 1954-12-15 | 796378881 | va.api.user+idme.004@gmail.com | Password1234! | va.api.user+idme.007@gmail.com | Airforce (Honorable) |
| PAULINE    | E           | FOSTER    | F | 1976-06-09 | 796330625 | va.api.user+idme.005@gmail.com | Password1234! | va.api.user+idme.007@gmail.com | Marines (Honorable) |
| RUSSELL    | James       | FREEMAN   | M | 1969-11-05 | 796149080 | va.api.user+idme.006@gmail.com | Password1234! | va.api.user+idme.007@gmail.com | Army/Airforce (Honorable/Dishonorable) |
| DOE        |             | JOHN      | M |            |           | va.api.user+idme.007@gmail.com | Password1234! | | Non-Veteran |
| GREG       | A           | ANDERSON  | M | 1933-04-05 | 796121200 | va.api.user+idme.008@gmail.com | Password1234! | | Inactive |
| GEORGE     |             | DENISE    | M | 1993-07-19 |           | va.api.user+idme.009@gmail.com | Password1234! | | Army (Honrable) |
| MONTGOMERY |             | TERRENCE  | M | 1969-06-11 |           | va.api.user+idme.010@gmail.com | Password1234! | | Airforce/Army (Honrable) |
| HECTOR     | J           | ALLEN     | M | 1932-02-05 | 796126859 | va.api.user+idme.011@gmail.com | Password1234! | | |
| ANDREA     | L           | MITCHELL  | F | 1959-12-01 | 796127781 | va.api.user+idme.012@gmail.com | Password1234! | | |
| KENNETH    | William     | ANDREWS   | M | 1990-02-20 | 796295980 | va.api.user+idme.013@gmail.com | Password1234! | | |
| ALFREDO    | M           | ARMSTRONG | M | 1993-06-08 | 796012476 | va.api.user+idme.014@gmail.com | Password1234! | | |
| FRANK      | LEE         | ARNOLD    | M | 1980-02-20 | 796143510 | va.api.user+idme.015@gmail.com | Password1234! | | |
| ERIC       | Victor      | BISHOP    | M | 1963-07-05 | 796169727 | va.api.user+idme.016@gmail.com | Password1234! | | |
| JERRY      | M           | BROOKS    | M | 1947-09-25 | 796148937 | va.api.user+idme.017@gmail.com | Password1234! | | |
| EDDIE      | J           | CALDWELL  | M | 1933-10-27 | 796121086 | va.api.user+idme.018@gmail.com | Password1234! | | |
| DEBBIE     | M           | CAMPBELL  | F | 1963-07-26 | 796249005 | va.api.user+idme.019@gmail.com | Password1234! | | |
| CHAD       | E           | BARRETT   | M | 1975-05-12 | 796263749 | va.api.user+idme.020@gmail.com | Password1234! | | |
| KYLE       | M           | COLE      | M | 1936-11-20 | 796131752 | va.api.user+idme.021@gmail.com | Password1234! | | |
| MARGIE     |             | CURTIS    | F | 1953-02-11 | 796163672 | va.api.user+idme.022@gmail.com | Password1234! | | |
| WILLIAM    | C           | DANIELS   | M | 1937-03-07 | 796127196 | va.api.user+idme.023@gmail.com | Password1234! | | |
| WALTER     | TYLER       | DAVIS     | M | 1987-01-30 | 796143570 | va.api.user+idme.024@gmail.com | Password1234! | | |
| WESLEY     | Watson      | FORD      | M | 1986-05-06 | 796043735 | va.api.user+idme.025@gmail.com | Password1234! | | |
| MELVIN     | V           | FREEMAN   | M | 1971-11-19 | 796184750 | va.api.user+idme.026@gmail.com | Password1234! | | |
| HERBERT    | MICHAEL     | GARDNER   | M | 1983-02-21 | 796122369 | va.api.user+idme.027@gmail.com | Password1234! | | |
| SAM        | ROBERT      | GARDNER   | M | 1969-06-23 | 796246997 | va.api.user+idme.028@gmail.com | Password1234! | | |
| JESSE      | J           | GEORGE    | M | 1950-01-31 | 796330163 | va.api.user+idme.029@gmail.com | Password1234! | | |
| SIDNEY     | A           | GIBSON    | M | 1933-08-04 | 796127094 | va.api.user+idme.030@gmail.com | Password1234! | | |
| JUNE       | R           | HARRIS    | F | 1955-12-27 | 796184459 | va.api.user+idme.031@gmail.com | Password1234! | | |
| JEFFERY    | J           | HAYES     | M | 1937-09-25 | 796131729 | va.api.user+idme.032@gmail.com | Password1234! | | |
| EVERETT    | Avery       | HORTON    | M | 1982-04-23 | 796377148 | va.api.user+idme.033@gmail.com | Password1234! | | |
| MATHEW     | A           | HOWELL    | M | 1927-01-18 | 796131275 | va.api.user+idme.034@gmail.com | Password1234! | | |
| JULIO      | E           | HUNTER    | M | 1951-11-18 | 796378321 | va.api.user+idme.035@gmail.com | Password1234! | | |
| JESUS      | A           | BARRETT   | M | 1947-06-29 | 796127587 | va.api.user+idme.036@gmail.com | Password1234! | | |
| DARYL      | F           | LAWRENCE  | M | 1953-02-15 | 796153447 | va.api.user+idme.037@gmail.com | Password1234! | | |
| MELVIN     | R           | MARSHALL  | M | 1992-08-27 | 796147495 | va.api.user+idme.038@gmail.com | Password1234! | | |
| ALFREDO    | J           | MORALES   | M | 1950-01-14 | 796122472 | va.api.user+idme.039@gmail.com | Password1234! | | |
| HARRY      | J           | OLSON     | M | 1979-06-20 | 796136308 | va.api.user+idme.040@gmail.com | Password1234! | | |
| CHRISTIAN  | Fitzgerald  | PATTERSON | M | 1964-03-04 | 796218467 | va.api.user+idme.041@gmail.com | Password1234! | | |
| JESSIE     | F           | PRICE     | M | 1934-04-07 | 796126978 | va.api.user+idme.042@gmail.com | Password1234! | | |
| ANA        | D           | RAY       | F | 1994-06-07 | 796025480 | va.api.user+idme.043@gmail.com | Password1234! | | |
| JENNY      | Kadeshia    | REID      | F | 1984-02-19 | 796364561 | va.api.user+idme.044@gmail.com | Password1234! | | |
| MARTIN     | Ray         | REID      | M | 1977-07-04 | 796018229 | va.api.user+idme.045@gmail.com | Password1234! | | |
| MATTIE     | May         | REID      | F | 1964-04-14 | 796109651 | va.api.user+idme.046@gmail.com | Password1234! | | |
| WILLARD    | J           | RILEY     | M | 1959-02-25 | 796013145 | va.api.user+idme.047@gmail.com | Password1234! | | |
| THEODORE   | Matthew     | ROBERTS   | M | 1986-02-28 | 796019724 | va.api.user+idme.048@gmail.com | Password1234! | | |
| JO         | M           | ROBERTSON | F | 1954-09-27 | 796044205 | va.api.user+idme.049@gmail.com | Password1234! | | |
| ARTHUR     | E           | ROSE      | M | 1954-05-26 | 796220828 | va.api.user+idme.050@gmail.com | Password1234! | | |
| SALVADOR   | H           | SIMS      | M | 1933-12-28 | 796013160 | va.api.user+idme.051@gmail.com | Password1234! | | |
| SAM        | Lee         | SPENCER   | M | 1965-03-26 | 796053870 | va.api.user+idme.052@gmail.com | Password1234! | | |
| FREDERICK  | Bradley     | SCOTT     | M | 1993-01-11 | 796128747 | va.api.user+idme.053@gmail.com | Password1234! | | |
| PENNY      | M           | SCOTT     | F | 1961-12-22 | 796128750 | va.api.user+idme.054@gmail.com | Password1234! | | |
| RAY        | A           | SCOTT     | M | 1978-04-19 | 796128748 | va.api.user+idme.055@gmail.com | Password1234! | | |
| DWAYNE     | E           | SPENCER   | M | 1958-02-24 | 796153369 | va.api.user+idme.056@gmail.com | Password1234! | | |
| BRIAN      | J           | STEPHENS  | M | 1939-08-20 | 796127242 | va.api.user+idme.057@gmail.com | Password1234! | | |
| RUTH       | Reyes       | STEPHENS  | F | 1982-07-10 | 796018805 | va.api.user+idme.058@gmail.com | Password1234! | | |
| DAVE       | A           | STEWART   | M | 1992-04-22 | 796110951 | va.api.user+idme.059@gmail.com | Password1234! | | |
| VERNON     | D           | WAGNER    | M | 1965-07-15 | 796140369 | va.api.user+idme.060@gmail.com | Password1234! | | |
| KENT       | L           | WARREN    | M | 1936-07-14 | 796127160 | va.api.user+idme.061@gmail.com | Password1234! | | |
| JEFF       | Terrel      | WATSON    | M | 1968-01-05 | 796246757 | va.api.user+idme.062@gmail.com | Password1234! | | |
| RUSSELL    | Renee       | WATSON    | M | 1961-09-02 | 796079018 | va.api.user+idme.063@gmail.com | Password1234! | | |
| GLEN       | Lee         | WELLS     | M | 1971-12-08 | 796231077 | va.api.user+idme.064@gmail.com | Password1234! | | |
| LEONARD    | A           | WHEELER   | M | 1959-11-01 | 796017172 | va.api.user+idme.065@gmail.com | Password1234! | | |
| LEONA      | C           | WILSON    | F | 1948-09-28 | 796066619 | va.api.user+idme.066@gmail.com | Password1234! | | |
| JAMIE      | J           | WOOD      | F | 1945-05-24 | 796060339 | va.api.user+idme.067@gmail.com | Password1234! | | |
| TOMMY      | V           | WRIGHT    | M | 1996-11-17 | 796030117 | va.api.user+idme.068@gmail.com | Password1234! | | |

## Health API Accounts

These users have a variety of synthetic health records defined for use with the VA Argonaut Health APIs.

| Email | Password      | Last Name | First Name | Gender | Birthdate |
|---|---|---|---|---|---|
| va.api.user+idme.101@gmail.com | Password1234! | Harris789      | Sheba703     | F | 1926-01-08 |
| va.api.user+idme.102@gmail.com | Password1234! | Ruelas156      | Mariano761   | M | 1907-11-20 |
| va.api.user+idme.103@gmail.com | Password1234! | Valentín837    | Lorenzo669   | M | 1942-01-11 |
| va.api.user+idme.104@gmail.com | Password1234! | Schmeler639    | Porfirio146  | M | 1916-06-15 |
| va.api.user+idme.105@gmail.com | Password1234! | Windler79      | Moshe758     | M | 1917-03-05 |
| va.api.user+idme.106@gmail.com | Password1234! | Goyette777     | Wayne846     | M | 1947-05-30 |
| va.api.user+idme.107@gmail.com | Password1234! | Renner328      | Ned189       | M | 1993-09-06 |
| va.api.user+idme.108@gmail.com | Password1234! | Kuhic920       | Harvey63     | M | 1927-10-21 |
| va.api.user+idme.109@gmail.com | Password1234! | Bergstrom287   | Jewell855    | M | 1945-10-19 |
| va.api.user+idme.110@gmail.com | Password1234! | Ferry570       | Bryan958     | M | 1939-01-24 |
| va.api.user+idme.111@gmail.com | Password1234! | Iglesias873    | Gilberto712  | M | 1926-04-05 |
| va.api.user+idme.112@gmail.com | Password1234! | Rohan584       | Al123        | M | 1996-12-07 |
| va.api.user+idme.113@gmail.com | Password1234! | Hermann103     | Chadwick722  | M | 1947-07-31 |
| va.api.user+idme.114@gmail.com | Password1234! | Mayer370       | Luis923      | M | 1969-07-03 |
| va.api.user+idme.115@gmail.com | Password1234! | Cruickshank494 | Aurelio227   | M | 1995-02-06 |
| va.api.user+idme.116@gmail.com | Password1234! | Terry864       | Jefferey580  | M | 1957-03-11 |
| va.api.user+idme.117@gmail.com | Password1234! | Mann644        | Taylor21   
| va.api.user+idme.118@gmail.com | Password1234! | Gutmann970     | Julius90     | M | 1947-11-13 |
| va.api.user+idme.119@gmail.com | Password1234! | Kautzer186     | Carlita746   | F | 1998-01-27 |
| va.api.user+idme.120@gmail.com | Password1234! | Reilly981      | Herb645      | M | 1993-10-14 |
| va.api.user+idme.121@gmail.com | Password1234! | Considine820   | Emmaline88   | F | 1914-03-08 |
| va.api.user+idme.122@gmail.com | Password1234! | Leal292        | Gerardo48    | M | 1944-01-21 |
| va.api.user+idme.123@gmail.com | Password1234! | Keebler762     | Boris111     | M | 1939-08-25 |
| va.api.user+idme.124@gmail.com | Password1234! | Mata817        | Vicente970   | M | 1919-01-11 |
| va.api.user+idme.125@gmail.com | Password1234! | Quigley282     | Danilo179    | M | 1992-01-25 |
| va.api.user+idme.126@gmail.com | Password1234! | McCullough561  | Kendrick479  | M | 1992-01-25 |
| va.api.user+idme.127@gmail.com | Password1234! | Bednar518      | Jarrett354   | M | 1908-10-09 |
| va.api.user+idme.128@gmail.com | Password1234! | Kris249        | Alex454      | F | 1940-11-11 |
| va.api.user+idme.129@gmail.com | Password1234! | Mosciski958    | Titus37      | M | 1942-04-15 |
| va.api.user+idme.130@gmail.com | Password1234! | Bechtelar572   | Ricardo560   | M | 1935-11-14 |
| va.api.user+idme.131@gmail.com | Password1234! | Vela532        | Miguel815    | M | 1983-08-10 |
| va.api.user+idme.132@gmail.com | Password1234! | Walsh511       | Cletus494    | M | 1937-07-19 |
| va.api.user+idme.133@gmail.com | Password1234! | Stark857       | Mariano761   | M | 1913-02-01 |
| va.api.user+idme.134@gmail.com | Password1234! | Bartell116     | Lorenzo669   | M | 1961-04-27 |
| va.api.user+idme.135@gmail.com | Password1234! | Runte676       | Renaldo199   | M | 1968-12-09 |
| va.api.user+idme.136@gmail.com | Password1234! | Lang846        | Art115       | M | 1947-04-24 |
| va.api.user+idme.137@gmail.com | Password1234! | Walter473      | Hai304       | M | 1950-11-26 |
| va.api.user+idme.138@gmail.com | Password1234! | Abernathy524   | Ollie731     | M | 1970-11-10 |
| va.api.user+idme.139@gmail.com | Password1234! | Schaden604     | Tyler508     | M | 1987-10-03 |
| va.api.user+idme.140@gmail.com | Password1234! | Brekke496      | Dan465       | M | 1987-01-29 |
| va.api.user+idme.141@gmail.com | Password1234! | Kiehn525       | Elmer371     | M | 1935-11-23 |
| va.api.user+idme.142@gmail.com | Password1234! | Nader710       | Marcelino726 | M | 1923-08-28 |
| va.api.user+idme.143@gmail.com | Password1234! | Barrows492     | Rebecca981   | F | 1962-11-08 |
| va.api.user+idme.144@gmail.com | Password1234! | Hartmann983    | Darryl392    | M | 1945-04-18 |
| va.api.user+idme.145@gmail.com | Password1234! | Hickle134      | Lavern240    | M | 1910-09-14 |
| va.api.user+idme.146@gmail.com | Password1234! | McKenzie376    | Damian46     | M | 1963-04-29 |
| va.api.user+idme.147@gmail.com | Password1234! | Mosciski958    | Vance413     | M | 1960-12-13 |
| va.api.user+idme.148@gmail.com | Password1234! | Fritsch593     | Hoyt490      | M | 1976-03-24 |
| va.api.user+idme.149@gmail.com | Password1234! | Wolff180       | Tobias236    | M | 1970-11-14 |
| va.api.user+idme.150@gmail.com | Password1234! | Bartell116     | Shane235     | M | 1958-11-10 |
| va.api.user+idme.151@gmail.com | Password1234! | Batz141        | Jc393        | M | 1975-09-06 |
| va.api.user+idme.152@gmail.com | Password1234! | Stroman228     | Emery884     | M | 1913-06-06 |
| va.api.user+idme.153@gmail.com | Password1234! | Raynor401      | Florentino8  | M | 1950-04-06 |
| va.api.user+idme.154@gmail.com | Password1234! | Roberts511     | Alvaro283    | M | 1935-08-02 |
| va.api.user+idme.155@gmail.com | Password1234! | Greenfelder433 | Derrick232   | M | 1947-12-17 |
| va.api.user+idme.156@gmail.com | Password1234! | Terry864       | Jon665       | M | 1984-11-02 |
| va.api.user+idme.157@gmail.com | Password1234! | Buckridge80    | Cornelius968 | M | 1920-06-29 |
| va.api.user+idme.158@gmail.com | Password1234! | Olson653       | Elias404     | M | 1918-01-01 |
| va.api.user+idme.159@gmail.com | Password1234! | Auer97         | Ethan766     | M | 1986-07-09 |
| va.api.user+idme.160@gmail.com | Password1234! | Barrows492     | Raymundo71   | M | 1997-06-21 |
| va.api.user+idme.161@gmail.com | Password1234! | Sanford861     | Chet188      | M | 1928-04-17 |
| va.api.user+idme.162@gmail.com | Password1234! | Lueilwitz711   | Nicholas495  | M | 1919-02-04 |
| va.api.user+idme.163@gmail.com | Password1234! | Little434      | Silas208     | M | 1924-07-29 |
| va.api.user+idme.164@gmail.com | Password1234! | Dietrich576    | Douglas31    | M | 1914-06-11 |
| va.api.user+idme.165@gmail.com | Password1234! | Haag279        | Geraldo282   | M | 1996-10-07 |
| va.api.user+idme.166@gmail.com | Password1234! | Bartoletti50   | Melvin857    | M | 1995-06-24 |
| va.api.user+idme.167@gmail.com | Password1234! | Prohaska837    | Freeman822   | M | 1915-05-08 |
| va.api.user+idme.168@gmail.com | Password1234! | Herman763      | Gino587      | M | 1936-10-09 |
| va.api.user+idme.169@gmail.com | Password1234! | Gorczany269    | Jasper743    | M | 1976-09-08 |
| va.api.user+idme.170@gmail.com | Password1234! | Jacobson885    | Alonso270    | M | 1935-07-06 |
| va.api.user+idme.171@gmail.com | Password1234! | Cronin387      | Anibal473    | M | 1916-12-02 |
| va.api.user+idme.172@gmail.com | Password1234! | Gerhold939     | Stevie682    | M | 1948-02-17 |
| va.api.user+idme.173@gmail.com | Password1234! | Wintheiser220  | Andres25     | M | 1941-05-01 |
| va.api.user+idme.174@gmail.com | Password1234! | Hayes766       | Dante562     | M | 1909-08-01 |
| va.api.user+idme.175@gmail.com | Password1234! | Aufderhar910   | Pasquale620  | M | 1931-03-25 |
| va.api.user+idme.176@gmail.com | Password1234! | Schultz619     | Alonso270    | M | 1922-01-10 |
| va.api.user+idme.177@gmail.com | Password1234! | Hirthe744      | Emilio417    | M | 1961-06-17 |
| va.api.user+idme.178@gmail.com | Password1234! | Williamson769  | Foster87     | M | 1938-08-11 |
| va.api.user+idme.179@gmail.com | Password1234! | O'Kon634       | Charley358   | M | 1992-08-17 |
| va.api.user+idme.180@gmail.com | Password1234! | Hegmann834     | Drew592      | M | 1981-07-09 |
| va.api.user+idme.181@gmail.com | Password1234! | Miller503      | Forrest301   | M | 1978-09-26 |
| va.api.user+idme.182@gmail.com | Password1234! | Cronin387      | Ward668      | M | 1939-03-04 |
| va.api.user+idme.183@gmail.com | Password1234! | Simonis280     | Reynaldo722  | M | 1909-04-04 |
