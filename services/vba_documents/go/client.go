package client

import (
	"encoding/json"
	"errors"
	"io"
	"net/http"
	"net/url"
)

const (
	DefaultAPIURL string = "https://api.vets.gov/"
	TokenHeader   string = "apikey"
	UserAgent     string = "vets-api/go"
)

type MetaService service
type DocumentUploadService service

type service struct{ client *VetsAPIClient }

type VetsAPIClient struct {
	Meta           *MetaService
	DocumentUpload *DocumentUploadService

	Url       *url.URL // URL of the Vets.gov API
	Key       string   // API authentication key
	Header    string   // header with authentication key
	UserAgent string

	common service
	client *http.Client
}

func NewClient(client *http.Client) *VetsAPIClient {
	baseURL, _ := url.Parse(DefaultAPIURL)

	if client == nil {
		client = http.DefaultClient
	}

	c := &VetsAPIClient{
		client:    client,
		Header:    TokenHeader,
		Url:       baseURL,
		UserAgent: UserAgent,
	}

	c.common.client = c
	c.Meta = (*MetaService)(&c.common)
	c.DocumentUpload = (*DocumentUploadService)(&c.common)

	return c
}

func (c *VetsAPIClient) NewRequest(method, path string, body io.Reader) (*http.Request, error) {
	u := c.Url
	u.Path = path

	req, err := http.NewRequest(method, u.String(), body)

	req.Header.Set(c.Header, c.Key)
	req.Header.Set("User-agent", c.UserAgent)

	return req, err
}

// Do performs the request and loads the response data into `v`
func (c *VetsAPIClient) Do(req *http.Request, v interface{}) (*http.Response, error) {
	resp, err := c.client.Do(req)
	if err != nil {
		return nil, err
	}

	// TODO(cgansen): should return known error types here instead
	if resp.StatusCode >= 400 {
		return resp, errors.New("http error: " + resp.Status)
	}

	// read the body if we have something to read into
	if v != nil {
		defer resp.Body.Close()
		if err := parseJsonResp(resp.Body, v); err != nil {
			return resp, err
		}
	}

	return resp, nil
}

// unmarshal the response into a structure for later processing
func parseJsonResp(body io.Reader, v interface{}) error {
	if err := json.NewDecoder(body).Decode(v); err != nil {
		return err
	}

	return nil
}
