docupload
========

## VA Lighthouse API documentation is now at [developer.va.gov](https://developer.va.gov)
`docupload` is a utility that demonstrates how to upload a document (sample.pdf) to the VBA documents service via the vets-api.

## Usage

```go
$ go get github.com/department-of-veterans-affairs/vets-api-clients/services/vba_documents/go/cmd/docupload
$ export VETS_API_TOKEN=your-api-token
$ ./docupload
2018/04/18 16:55:49 starting upload to s3 for doc b2819fcb-22de-48e1-a70b-2f7ea17da0cb
2018/04/18 16:55:50 upload to S3 is complete
2018/04/18 16:55:51 upload b2819fcb-22de-48e1-a70b-2f7ea17da0cb has status pending
2018/04/18 16:55:57 upload b2819fcb-22de-48e1-a70b-2f7ea17da0cb has status uploaded
2018/04/18 16:56:03 upload b2819fcb-22de-48e1-a70b-2f7ea17da0cb has status received
```
