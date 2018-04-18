package client

import (
	"net/url"
)

type vetsApiResponse struct {
	Data vetsApiResponseData `json:"data"`
}

type vetsApiResponseData struct {
	Attributes vetsApiResponseAttributes `json:"attributes"`
	ID         string                    `json:"id"`
	Type       string                    `json:"type"`
}

type vetsApiResponseAttributes struct {
	GUID     string `json:"guid"`
	Location string `json:"location"`
	Status   string `json:"status"`
}

// Start() will initiate the upload process and return the URL to upload the document data to
func (c *DocumentUploadService) Start() (string, *url.URL, error) {
	u := &url.URL{}

	req, err := c.client.NewRequest("POST", "/services/vba_documents/v0/uploads", nil)
	if err != nil {
		return "", u, err
	}

	var data vetsApiResponse
	_, err = c.client.Do(req, &data)
	if err != nil {
		return "", u, err
	}

	u, err = url.Parse(data.Data.Attributes.Location)
	if err != nil {
		return "", u, err
	}

	return data.Data.Attributes.GUID, u, nil
}

// Status() will return the status of a given document upload
func (c *DocumentUploadService) Status(guid string) (string, error) {
	req, err := c.client.NewRequest("GET", "/services/vba_documents/v0/uploads/"+guid, nil)
	if err != nil {
		return "", err
	}

	var data vetsApiResponse
	_, err = c.client.Do(req, &data)
	if err != nil {
		return "", err
	}

	return data.Data.Attributes.Status, nil
}
