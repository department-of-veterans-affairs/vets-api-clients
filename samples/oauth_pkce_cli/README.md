## PKCE Command Line

This tool demonstrates the Authorization Code Flow with PKCE 

It follows these steps:

1. Creates a random string called the `code verifier`
2. Hashes the `code verifier` creating a value called the `code challenge`
3. Builds an authorization URL which includes:
    a. OIDC Client ID
    b. a list of request scopes
    c. a redirect uri
    d. a randomly generated state value
    e. the `code challenge`
    f. a response type set to `code` to indicate that we're using the authorization code flow
4. Launches a browser with the authorization URL, at which point you will authenticate
5. Receives the redirect from the authorization url, which includes a `code`
6. Calls the `token` endpoint with:
    a. grant type set to `authorization code`
    b. a redirect uri that must match the one used in the authorization step
    c. OIDC Client ID
    d. the `code`
    e. the `code verifier` from earlier
7. Displays the tokens returned from the `token` endpoint
8. Uses the returned access token to call the `userinfo` endpoint

## Usage

```
Usage: pkce-cli [options]

Options:
  -c, --client_id <client id>                    OIDC Client ID (default: "")
  -a, --auth_server <auth server url>            ex: https://sandbox-api.va.gov (default: "")
  -s, --scopes <space separated list of scopes>  Space separated list of scopes (default: "")
  -r, --redirect_uri <redirect uri>              redirect uri (default: "http://localhost:8080/redirect")
  -h, --help                                     output usage information
```
If you have issues running the usage statement above run

```
npm install
```
and then retry.

## Run

```
npm install
./pkce-cli \
  --client_id 00000000000000000000 \
  --auth_server https://sandbox-api.va.gov \
  --scopes "openid profile email" \
  --redirect_uri http://localhost:8080/redirect 
```

You'll get output like this, along with prompts to continue, as well as a browser session being initiated to authenticate a user:

```
Created Code Verifier (v): 0233_39e5_6b3d_70b6_087f_b675_cc62_b178_ce21_577f_d661

Created Code Challenge ($): Y3LBgtM-gcL_gEw-TGt26uOqNtnBO2nWXEwm_GC5Oh4

Calling Authorize URL: https://sandbox-api.va.gov/oauth2/v1/authorization?client_id=00000000000000000000&response_type=code&scope=openid profile email&redirect_uri=http://localhost:8080/redirect&state=f3a5_f3a7_051f_2f97_f147_272a_d074_86fb_7d08_8650_3d8b&code_challenge_method=S256&code_challenge=Y3LBgtM-gcL_gEw-TGt26uOqNtnBO2nWXEwm_GC5Oh4

Got code (α): C3LZZVjIYkOsjh42XTpZ

Calling /token endpoint with:
client_id: 00000000000000000000
code_verifier (v): 0233_39e5_6b3d_70b6_087f_b675_cc62_b178_ce21_577f_d661
code (α): C3LZZVjIYkOsjh42XTpZ

Here is the form post that will be sent to the /token endpoint:
{ grant_type: 'authorization_code',
  redirect_uri: 'http://localhost:8080/redirect',
  client_id: '00000000000000000000',
  code: 'C3LZZVjIYkOsjh42XTpZ',
  code_verifier: '0233_39e5_6b3d_70b6_087f_b675_cc62_b178_ce21_577f_d661' }

Got token response:
{ access_token:
   'eyJraWQiOiItVV92MHBJVGx5X0V3MTJfTzZuT1lWb081ZVBucm1Iek9wbkxfS2FHN0lzIiwiYWxnIjoiUlMyNTYifQ.eyJ2ZXIiOjEsImp0aSI6IkFULnloZ0k4WFRTVWhrQ0dRT28xSVQwSXVYd3pSc094Rm5HY2xDNmN2bkFEMlkiLCJpc3MiOiJodHRwczovL21pY2FoLm9rdGFwcmV2aWV3LmNvbSIsImF1ZCI6Imh0dHBzOi8vbWljYWgub2t0YXByZXZpZXcuY29tIiwic3ViIjoibWljYWhAYWZpdG5lcmQuY29tIiwiaWF0IjoxNTQyMzg5NjY2LCJleHAiOjE1NDIzOTMyNjYsImNpZCI6IjBvYWhkaWZjNzJVUmg3clVWMGg3IiwidWlkIjoiMDB1ZG8zYmFseE5od0tkU0wwaDciLCJzY3AiOlsicHJvZmlsZSIsIm9wZW5pZCIsImVtYWlsIl19.db85XwSTta0UpxySopx6A66kBWybJtxgYZSP0EGoiTFV1dHHhlGR563J3zaF94a6m8rSIM9g_O_HBskLYr7uaZVTIlVq0pgT9v8NQ2dvwl5f0br9dfYgBv-ftGaSUr5BGJYTgM3urvx0x7M5HME_Me3id7tFQydvvcgJFOn_2nY8f-usy1jT8aJtOuxcgYqWrOVJmJJVRnI6tB8T7LT1GmIR9pe9dxaJxubqYIkCO2UeUCpBoLJ3duTpSIAmOFyMH1gxdXLHD4xQaBm-AKfMvLPSvEi-pH1soCXGX1dQVuwgBAiF7sNJNb4WueXu92AcSzma3jtEh0ri5RCYxywAbA',
  token_type: 'Bearer',
  expires_in: 3600,
  scope: 'profile openid email',
  id_token:
   'eyJraWQiOiJUcGwtaVowcHhtQWpZb05ISlVSLUtjWkdCMGdUTWFUYkd1clQwd19GMXgwIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiIwMHVkbzNiYWx4Tmh3S2RTTDBoNyIsIm5hbWUiOiJNaWNhaCBTaWx2ZXJtYW4iLCJlbWFpbCI6Im1pY2FoQGFmaXRuZXJkLmNvbSIsInZlciI6MSwiaXNzIjoiaHR0cHM6Ly9taWNhaC5va3RhcHJldmlldy5jb20iLCJhdWQiOiIwb2FoZGlmYzcyVVJoN3JVVjBoNyIsImlhdCI6MTU0MjM4OTY2NiwiZXhwIjoxNTQyMzkzMjY2LCJqdGkiOiJJRC5fS09kSjZITnpzNkpESkZHUEk5dlpTOHNkMk1memdGUW55bEpoRFpxaW53IiwiYW1yIjpbInB3ZCJdLCJpZHAiOiIwMG85dmFza2sySnQyWEZWZzBoNyIsInByZWZlcnJlZF91c2VybmFtZSI6Im1pY2FoQGFmaXRuZXJkLmNvbSIsImF1dGhfdGltZSI6MTU0MjM4OTYxMSwiYXRfaGFzaCI6IkQ3eU93WldjbzRTbFhGXzJJNnJpN0EifQ.XL1yFsx5gHl4fvngvTwVJwncfCyb5YwClwFpGsrUKr0MFDWBZuNmPvfPOFDBVkHbYmqUi3bajSYij7buI0mxauTJ1ZeqKeepUwLuVyKq94qbyHFXgvSlGXBYSXHA4sfJswJVSdkaoCXenyXTJJbcPuzYq6wpGt9a8ri4dq1cQ70UnXdgMTfbCGW_9Q6Tzv1wZa-GEB5i6iAfktrETORjMyFsGIAFaRQY5wdmsIf6LT3uIjKU7y4mq-X6rTJyJlkjmGxZv1QP0kfKiTSsGqeWt-s1-XinEtfnkOlLALNNIAo2MfB8cT88ixPZvCSt7VAzD_eBs8n_HkMqLQot4bs_Tw' }
```
