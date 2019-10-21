# vets-api sample cURL client
## VA Lighthouse API documentation is now at [developer.va.gov](https://developer.va.gov)

## Configuration

### Dependencies

The client requires these applications to be installed:

- `curl`: https://curl.haxx.se/
- `jq`: https://stedolan.github.io/jq/

Both packages are present in common Linux package repositories (yum, apt-get, etc), and on OS X via [Homebrew](https://brew.sh/).

### Configuration

You must provide your vets-api authentication token via an environment variable, `VETS_API_TOKEN`.

```bash
export VETS_API_TOKEN=your-token-value
```

You may specify an alternate vets-api endpoint by setting the `VETS_API_URL` environment variable. If unset, the client will use the production API URL: https://api.va.gov/.

### Usage

This command will upload a PDF file annotated with metadata to the Vets API.

```bash
client.sh /path/to/your/file.pdf /path/to/your/metadata.json
```

The script with exit with `0` on success, non-zero on any error.

See [metadata.json](./metadata.json) for the minimal metadata allowed. Consult the API documentation (TK: link to public docs) for an exhaustive list of metadata fields.

Note: the client does not perform any validation on your inputs. Its behavior when provided a non-PDF or invalid JSON metadata file is not specified.

