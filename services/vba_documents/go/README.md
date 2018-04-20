# vets-api Go Client

This package is a vets-api client written in [Go](https://golang.org) as well as sample implementations.

The client implements two vets-api services:

- `meta`: information about the vets-api system
- `vba_documents`: submit documents to the VBA documents system.

## Usage

See [cmd/vetsapitester](./cmd/vetsapitester/) for an API client that verifies connectivity and authentication.

The [cmd/docupload](./cmd/docupload/) utility can perform document uploads to the VBA documents service.

To use the client in your own application, include the package and create a new client:

```go
package main

import (
	"fmt"

	vetsapi "github.com/department-of-veterans-affairs/vets-api-clients/services/vba_documents/go"
)

func main() {
	c := vetsapi.NewClient(nil)
	c.Key = "your-api-key"

	// try a ping
	if err := c.Meta.Ping(); err != nil {
		fmt.Fatalln(err)
	}
}
```

## Testing

TK: tests

## Notes

The structure of the client code is heavily indebted to the [go-github project](https://github.com/google/go-github).

This project uses the [vgo](https://github.com/golang/vgo) utility to manage dependencies.
