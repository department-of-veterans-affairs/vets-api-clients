#!/bin/bash

# upload a PDF to the vets-api VBA document service
#
# usage:
#
#   ./client.sh /path/to/your.pdf /path/to/metadata.json
#

set -e

apiUrl=${VETS_API_URL:-"https://dev-api.vets.gov"}
token=${VETS_API_TOKEN:-"invalid-token"}
tokenHeader="apiKey"

if [ "$token" == "invalid-token" ]; then
  echo "error: you must provide an API token in the VETS_API_TOKEN environment variable"
  exit 1
fi

if [ "$#" -ne 2 ]; then
  echo "usage: client.sh <document.pdf> <metadata.json>"
  exit 2
fi

echo "starting document upload to $apiUrl"

# tell the vets-api about the upload
resp=$(curl \
  -s \
  -X "POST" \
  -H "$tokenHeader: $token" \
  "$apiUrl/services/vba_documents/v0/uploads"
)

# parse out the response
guid=$(echo $resp | jq -r .data.attributes.guid)
s3location=$(echo $resp | jq -r .data.attributes.location)

if [ "$s3location" == "null" ]; then
  echo "error: did not receive a URL from $apiUrl for S3 upload"
  exit 1
fi

# upload data to S3
echo "uploading PDF to S3 using URL: $s3location"
curl -X PUT \
  -s \
  $s3location \
  -H 'Content-type: ""' \
  -F "content=@$1;type=application/pdf" \
  -F "metadata=<$2;type=application/json" > /dev/null 2>&1

# poll for status update

status="pending"
echo "polling every 5 seconds for status..."
while [ "$status" == "pending" -o "$status" == "uploaded" ]
do
  status=$(curl \
    -X GET \
    -H "$tokenHeader: $token" \
    -s "$apiUrl/services/vba_documents/v0/uploads/$guid" | jq -r .data.attributes.status)
  echo "status is: $status"
  sleep 5
done

echo "status is: $status"
echo "done."
