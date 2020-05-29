# VA Lighthouse OAuth Test User Accounts

These are test accounts you can use to test OAuth APIs by logging in with them through the ID.me sandbox environment that is connected to sandbox-api.va.gov.  When signing in with a test account, Step 2 will ask how you want to receive an authentication code. You can just click "continue" for the verification to be automatically populated in Step 3.


## Representative OAuth

The purpose behind Representative OAuth is to allow you to login as a Representative user who holds power of attorney (PoA) for a particular veteran through the OAuth and ID.me system and then use the token you've collected to access that Veteran's data (currently only available in our [Claims V1 API's](https://developer.va.gov/explore/benefits/docs/claims?version=current)). This process involves us looking at which Office of General Counsel (OGC) PoA code the veteran has and matching it to the PoA code the Representative is authorized to access. Example of a Representative cURL command is provided below.

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

The Representative users 001 (Tamara Ellis) and 007 (John Doe) have Power of Attorney for Veteran users 003 (Ralph Lee), 004 (Jesse Gray), 005 (Pauline Foster) and 006 (Russell Freeman). User 007 (John Doe) also has PoA for 001 (Tamara Ellis). This is meant to demonstrate how both a Veteran and a Non-Veteran can be granted power of attorney access.

**Do not modify any of the attributes for these test accounts, including passwords.** 

<ins>The password for all users is:</ins>  Password1234!

| First Name | Middle Name | Last Name | Sex | Birthdate  | SSN       | Email                          | 
| --- | --- | --- | --- | --- | --- | --- | 
| TAMARA     | E           | ELLIS     | F | 1967-06-19 | 796130115 | va.api.user+idme.001@gmail.com | 
| JANET      | L           | MOORE     | F | 1949-05-06 | 796127677 | va.api.user+idme.002@gmail.com | 
| RALPH      | E           | LEE       | M | 1948-10-30 | 796378782 | va.api.user+idme.003@gmail.com |
| JESSE      |             | GRAY      | M | 1954-12-15 | 796378881 | va.api.user+idme.004@gmail.com |
| PAULINE    | E           | FOSTER    | F | 1976-06-09 | 796330625 | va.api.user+idme.005@gmail.com | 
| RUSSELL    | James       | FREEMAN   | M | 1969-11-05 | 796149080 | va.api.user+idme.006@gmail.com | 
| DOE        |             | JOHN      | M |            |           | va.api.user+idme.007@gmail.com | 
| GREG       | A           | ANDERSON  | M | 1933-04-05 | 796121200 | va.api.user+idme.008@gmail.com | 
| GEORGE     |             | DENISE    | M | 1993-07-19 |           | va.api.user+idme.009@gmail.com | 
| MONTGOMERY |             | TERRENCE  | M | 1969-06-11 |           | va.api.user+idme.010@gmail.com | 
| HECTOR     | J           | ALLEN     | M | 1932-02-05 | 796126859 | va.api.user+idme.011@gmail.com | 
| ANDREA     | L           | MITCHELL  | F | 1959-12-01 | 796127781 | va.api.user+idme.012@gmail.com | 
| KENNETH    | William     | ANDREWS   | M | 1990-02-20 | 796295980 | va.api.user+idme.013@gmail.com | 
| ALFREDO    | M           | ARMSTRONG | M | 1993-06-08 | 796012476 | va.api.user+idme.014@gmail.com | 
| FRANK      | LEE         | ARNOLD    | M | 1980-02-20 | 796143510 | va.api.user+idme.015@gmail.com | 
| ERIC       | Victor      | BISHOP    | M | 1963-07-05 | 796169727 | va.api.user+idme.016@gmail.com | 
| JERRY      | M           | BROOKS    | M | 1947-09-25 | 796148937 | va.api.user+idme.017@gmail.com | 
| EDDIE      | J           | CALDWELL  | M | 1933-10-27 | 796121086 | va.api.user+idme.018@gmail.com | 
| DEBBIE     | M           | CAMPBELL  | F | 1963-07-26 | 796249005 | va.api.user+idme.019@gmail.com | 
| CHAD       | E           | BARRETT   | M | 1975-05-12 | 796263749 | va.api.user+idme.020@gmail.com | 
| KYLE       | M           | COLE      | M | 1936-11-20 | 796131752 | va.api.user+idme.021@gmail.com | 
| MARGIE     |             | CURTIS    | F | 1953-02-11 | 796163672 | va.api.user+idme.022@gmail.com | 
| WILLIAM    | C           | DANIELS   | M | 1937-03-07 | 796127196 | va.api.user+idme.023@gmail.com | 
| WALTER     | TYLER       | DAVIS     | M | 1987-01-30 | 796143570 | va.api.user+idme.024@gmail.com | 
| WESLEY     | Watson      | FORD      | M | 1986-05-06 | 796043735 | va.api.user+idme.025@gmail.com | 
| MELVIN     | V           | FREEMAN   | M | 1971-11-19 | 796184750 | va.api.user+idme.026@gmail.com | 
| HERBERT    | MICHAEL     | GARDNER   | M | 1983-02-21 | 796122369 | va.api.user+idme.027@gmail.com | 
| SAM        | ROBERT      | GARDNER   | M | 1969-06-23 | 796246997 | va.api.user+idme.028@gmail.com | 
| JESSE      | J           | GEORGE    | M | 1950-01-31 | 796330163 | va.api.user+idme.029@gmail.com | 
| SIDNEY     | A           | GIBSON    | M | 1933-08-04 | 796127094 | va.api.user+idme.030@gmail.com | 
| JUNE       | R           | HARRIS    | F | 1955-12-27 | 796184459 | va.api.user+idme.031@gmail.com | 
| JEFFERY    | J           | HAYES     | M | 1937-09-25 | 796131729 | va.api.user+idme.032@gmail.com |
| EVERETT    | Avery       | HORTON    | M | 1982-04-23 | 796377148 | va.api.user+idme.033@gmail.com | 
| MATHEW     | A           | HOWELL    | M | 1927-01-18 | 796131275 | va.api.user+idme.034@gmail.com | 
| JULIO      | E           | HUNTER    | M | 1951-11-18 | 796378321 | va.api.user+idme.035@gmail.com | 
| JESUS      | A           | BARRETT   | M | 1947-06-29 | 796127587 | va.api.user+idme.036@gmail.com | 
| DARYL      | F           | LAWRENCE  | M | 1953-02-15 | 796153447 | va.api.user+idme.037@gmail.com | 
| MELVIN     | R           | MARSHALL  | M | 1992-08-27 | 796147495 | va.api.user+idme.038@gmail.com | 
| ALFREDO    | J           | MORALES   | M | 1950-01-14 | 796122472 | va.api.user+idme.039@gmail.com | 
| HARRY      | J           | OLSON     | M | 1979-06-20 | 796136308 | va.api.user+idme.040@gmail.com | 
| CHRISTIAN  | Fitzgerald  | PATTERSON | M | 1964-03-04 | 796218467 | va.api.user+idme.041@gmail.com | 
| JESSIE     | F           | PRICE     | M | 1934-04-07 | 796126978 | va.api.user+idme.042@gmail.com | 
| ANA        | D           | RAY       | F | 1994-06-07 | 796025480 | va.api.user+idme.043@gmail.com | 
| JENNY      | Kadeshia    | REID      | F | 1984-02-19 | 796364561 | va.api.user+idme.044@gmail.com | 
| MARTIN     | Ray         | REID      | M | 1977-07-04 | 796018229 | va.api.user+idme.045@gmail.com | 
| MATTIE     | May         | REID      | F | 1964-04-14 | 796109651 | va.api.user+idme.046@gmail.com | 
| WILLARD    | J           | RILEY     | M | 1959-02-25 | 796013145 | va.api.user+idme.047@gmail.com | 
| THEODORE   | Matthew     | ROBERTS   | M | 1986-02-28 | 796019724 | va.api.user+idme.048@gmail.com | 
| JO         | M           | ROBERTSON | F | 1954-09-27 | 796044205 | va.api.user+idme.049@gmail.com | 
| ARTHUR     | E           | ROSE      | M | 1954-05-26 | 796220828 | va.api.user+idme.050@gmail.com | 
| SALVADOR   | H           | SIMS      | M | 1933-12-28 | 796013160 | va.api.user+idme.051@gmail.com | 
| SAM        | Lee         | SPENCER   | M | 1965-03-26 | 796053870 | va.api.user+idme.052@gmail.com | 
| FREDERICK  | Bradley     | SCOTT     | M | 1993-01-11 | 796128747 | va.api.user+idme.053@gmail.com | 
| PENNY      | M           | SCOTT     | F | 1961-12-22 | 796128750 | va.api.user+idme.054@gmail.com | 
| RAY        | A           | SCOTT     | M | 1978-04-19 | 796128748 | va.api.user+idme.055@gmail.com | 
| DWAYNE     | E           | SPENCER   | M | 1958-02-24 | 796153369 | va.api.user+idme.056@gmail.com | 
| BRIAN      | J           | STEPHENS  | M | 1939-08-20 | 796127242 | va.api.user+idme.057@gmail.com | 
| RUTH       | Reyes       | STEPHENS  | F | 1982-07-10 | 796018805 | va.api.user+idme.058@gmail.com | 
| DAVE       | A           | STEWART   | M | 1992-04-22 | 796110951 | va.api.user+idme.059@gmail.com | 
| VERNON     | D           | WAGNER    | M | 1965-07-15 | 796140369 | va.api.user+idme.060@gmail.com | 
| KENT       | L           | WARREN    | M | 1936-07-14 | 796127160 | va.api.user+idme.061@gmail.com | 
| JEFF       | Terrel      | WATSON    | M | 1968-01-05 | 796246757 | va.api.user+idme.062@gmail.com | 
| RUSSELL    | Renee       | WATSON    | M | 1961-09-02 | 796079018 | va.api.user+idme.063@gmail.com | 
| GLEN       | Lee         | WELLS     | M | 1971-12-08 | 796231077 | va.api.user+idme.064@gmail.com | 
| LEONARD    | A           | WHEELER   | M | 1959-11-01 | 796017172 | va.api.user+idme.065@gmail.com | 
| LEONA      | C           | WILSON    | F | 1948-09-28 | 796066619 | va.api.user+idme.066@gmail.com | 
| JAMIE      | J           | WOOD      | F | 1945-05-24 | 796060339 | va.api.user+idme.067@gmail.com | 
| TOMMY      | V           | WRIGHT    | M | 1996-11-17 | 796030117 | va.api.user+idme.068@gmail.com | 

## Health API Accounts

These users have a variety of synthetic health records defined for use with the VA Argonaut Health APIs.

<ins>The password for all users is:</ins>  Password1234!

|First Name |Last Name  |Gender |Birthdate   |Email |
|--- |--- |--- |--- |--- |
||||||
|Sheba703|Harris789|F|1926-01-08|va.api.user+idme.101@gmail.com|
|Mariano761|Ruelas156|M|1907-11-20|va.api.user+idme.102@gmail.com|
|Lorenzo669|Valentín837|M|1942-01-11|va.api.user+idme.103@gmail.com|
|Porfirio146|Schmeler639|M|1916-06-15|va.api.user+idme.104@gmail.com|
|Moshe758|Windler79|M|1917-03-05|va.api.user+idme.105@gmail.com|
|Wayne846|Goyette777|M|1947-05-30|va.api.user+idme.106@gmail.com|
|Ned189|Renner328|M|1993-09-06|va.api.user+idme.107@gmail.com|
|Harvey63|Kuhic920|M|1927-10-21|va.api.user+idme.108@gmail.com|
|Jewell855|Bergstrom287|M|1945-10-19|va.api.user+idme.109@gmail.com|
|Bryan958|Ferry570|M|1939-01-24|va.api.user+idme.110@gmail.com|
|Gilberto712|Iglesias873|M|1926-04-05|va.api.user+idme.111@gmail.com|
|Al123|Rohan584|M|1996-12-07|va.api.user+idme.112@gmail.com|
|Chadwick722|Hermann103|M|1947-07-31|va.api.user+idme.113@gmail.com|
|Luis923|Mayer370|M|1969-07-03|va.api.user+idme.114@gmail.com|
|Aurelio227|Cruickshank494|M|1995-02-06|va.api.user+idme.115@gmail.com|
|Jefferey580|Terry864|M|1957-03-11|va.api.user+idme.116@gmail.com|
|Taylor21|Mann644|||va.api.user+idme.117@gmail.com|
|Julius90|Gutmann970|M|1947-11-13|va.api.user+idme.118@gmail.com|
|Carlita746|Kautzer186|F|1998-01-27|va.api.user+idme.119@gmail.com|
|Herb645|Reilly981|M|1993-10-14|va.api.user+idme.120@gmail.com|
|Emmaline88|Considine820|F|1914-03-08|va.api.user+idme.121@gmail.com|
|Gerardo48|Leal292|M|1944-01-21|va.api.user+idme.122@gmail.com|
|Boris111|Keebler762|M|1939-08-25|va.api.user+idme.123@gmail.com|
|Vicente970|Mata817|M|1919-01-11|va.api.user+idme.124@gmail.com|
|Danilo179|Quigley282|M|1992-01-25|va.api.user+idme.125@gmail.com|
|Kendrick479|McCullough561|M|1992-01-25|va.api.user+idme.126@gmail.com|
|Jarrett354|Bednar518|M|1908-10-09|va.api.user+idme.127@gmail.com|
|Alex454|Kris249|F|1940-11-11|va.api.user+idme.128@gmail.com|
|Titus37|Mosciski958|M|1942-04-15|va.api.user+idme.129@gmail.com|
|Ricardo560|Bechtelar572|M|1935-11-14|va.api.user+idme.130@gmail.com|
|Miguel815|Vela532|M|1983-08-10|va.api.user+idme.131@gmail.com|
|Cletus494|Walsh511|M|1937-07-19|va.api.user+idme.132@gmail.com|
|Mariano761|Stark857|M|1913-02-01|va.api.user+idme.133@gmail.com|
|Lorenzo669|Bartell116|M|1961-04-27|va.api.user+idme.134@gmail.com|
|Renaldo199|Runte676|M|1968-12-09|va.api.user+idme.135@gmail.com|
|Art115|Lang846|M|1947-04-24|va.api.user+idme.136@gmail.com|
|Hai304|Walter473|M|1950-11-26|va.api.user+idme.137@gmail.com|
|Ollie731|Abernathy524|M|1970-11-10|va.api.user+idme.138@gmail.com|
|Tyler508|Schaden604|M|1987-10-03|va.api.user+idme.139@gmail.com|
|Dan465|Brekke496|M|1987-01-29|va.api.user+idme.140@gmail.com|
|Elmer371|Kiehn525|M|1935-11-23|va.api.user+idme.141@gmail.com|
|Marcelino726|Nader710|M|1923-08-28|va.api.user+idme.142@gmail.com|
|Rebecca981|Barrows492|F|1962-11-08|va.api.user+idme.143@gmail.com|
|Darryl392|Hartmann983|M|1945-04-18|va.api.user+idme.144@gmail.com|
|Lavern240|Hickle134|M|1910-09-14|va.api.user+idme.145@gmail.com|
|Damian46|McKenzie376|M|1963-04-29|va.api.user+idme.146@gmail.com|
|Vance413|Mosciski958|M|1960-12-13|va.api.user+idme.147@gmail.com|
|Hoyt490|Fritsch593|M|1976-03-24|va.api.user+idme.148@gmail.com|
|Tobias236|Wolff180|M|1970-11-14|va.api.user+idme.149@gmail.com|
|Shane235|Bartell116|M|1958-11-10|va.api.user+idme.150@gmail.com|
|Jc393|Batz141|M|1975-09-06|va.api.user+idme.151@gmail.com|
|Emery884|Stroman228|M|1913-06-06|va.api.user+idme.152@gmail.com|
|Florentino8|Raynor401|M|1950-04-06|va.api.user+idme.153@gmail.com|
|Alvaro283|Roberts511|M|1935-08-02|va.api.user+idme.154@gmail.com|
|Derrick232|Greenfelder433|M|1947-12-17|va.api.user+idme.155@gmail.com|
|Jon665|Terry864|M|1984-11-02|va.api.user+idme.156@gmail.com|
|Cornelius968|Buckridge80|M|1920-06-29|va.api.user+idme.157@gmail.com|
|Elias404|Olson653|M|1918-01-01|va.api.user+idme.158@gmail.com|
|Ethan766|Auer97|M|1986-07-09|va.api.user+idme.159@gmail.com|
|Raymundo71|Barrows492|M|1997-06-21|va.api.user+idme.160@gmail.com|
|Chet188|Sanford861|M|1928-04-17|va.api.user+idme.161@gmail.com|
|Nicholas495|Lueilwitz711|M|1919-02-04|va.api.user+idme.162@gmail.com|
|Silas208|Little434|M|1924-07-29|va.api.user+idme.163@gmail.com|
|Douglas31|Dietrich576|M|1914-06-11|va.api.user+idme.164@gmail.com|
|Geraldo282|Haag279|M|1996-10-07|va.api.user+idme.165@gmail.com|
|Melvin857|Bartoletti50|M|1995-06-24|va.api.user+idme.166@gmail.com|
|Freeman822|Prohaska837|M|1915-05-08|va.api.user+idme.167@gmail.com|
|Gino587|Herman763|M|1936-10-09|va.api.user+idme.168@gmail.com|
|Jasper743|Gorczany269|M|1976-09-08|va.api.user+idme.169@gmail.com|
|Alonso270|Jacobson885|M|1935-07-06|va.api.user+idme.170@gmail.com|
|Anibal473|Cronin387|M|1916-12-02|va.api.user+idme.171@gmail.com|
|Stevie682|Gerhold939|M|1948-02-17|va.api.user+idme.172@gmail.com|
|Andres25|Wintheiser220|M|1941-05-01|va.api.user+idme.173@gmail.com|
|Dante562|Hayes766|M|1909-08-01|va.api.user+idme.174@gmail.com|
|Pasquale620|Aufderhar910|M|1931-03-25|va.api.user+idme.175@gmail.com|
|Alonso270|Schultz619|M|1922-01-10|va.api.user+idme.176@gmail.com|
|Emilio417|Hirthe744|M|1961-06-17|va.api.user+idme.177@gmail.com|
|Foster87|Williamson769|M|1938-08-11|va.api.user+idme.178@gmail.com|
|Charley358|O'Kon634|M|1992-08-17|va.api.user+idme.179@gmail.com|
|Drew592|Hegmann834|M|1981-07-09|va.api.user+idme.180@gmail.com|
|Forrest301|Miller503|M|1978-09-26|va.api.user+idme.181@gmail.com|
|Ward668|Cronin387|M|1939-03-04|va.api.user+idme.182@gmail.com|
|Reynaldo722|Simonis280|M|1909-04-04|va.api.user+idme.183@gmail.com|
