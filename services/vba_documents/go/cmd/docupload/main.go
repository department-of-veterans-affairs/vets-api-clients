package main // import "github.com/department-of-veterans-affairs/vets-api-clients/services/vba_documents/go"

import (
	"bytes"
	"io"
	"log"
	"mime/multipart"
	"net/http"
	"net/textproto"
	"net/url"
	"os"
	"time"

	vetsapi "github.com/department-of-veterans-affairs/vets-api-clients/services/vba_documents/go"
)

// api.vets.gov sample client

func main() {
	key := os.Getenv("VETS_API_TOKEN")
	if key == "" {
		log.Println("VETS_API_TOKEN is unset. Please provide your API key as an environment variable")
		os.Exit(-1)
	}

	c := vetsapi.NewClient(nil)
	c.Key = key

	// host override
	host := os.Getenv("VETS_API_URL")
	if host != "" {
		u, err := url.Parse(host)
		if err != nil {
			log.Println("VETS_API_HOST is invalid: ", err)
			os.Exit(-1)
		}
		c.Url = u
	}

	// start an upload
	guid, url, err := c.DocumentUpload.Start()
	if err != nil {
		log.Printf("error starting upload: %s", err)
		os.Exit(-1)
	}

	log.Println("starting upload to s3 for doc", guid)

	f, err := os.Open("sample.pdf")
	if err != nil {
		log.Fatalf("error opening file: %s", err)
	}
	defer f.Close()

	fm, err := os.Open("metadata.json")
	if err != nil {
		log.Fatalf("error opening file: %s", err)
	}
	defer fm.Close()

	// create a multipart upload
	body := new(bytes.Buffer)
	writer := multipart.NewWriter(body)

	// CreateFormPart doesn't set the MIME type of the part
	// so we use CreatePart instead, allowing custom content-type
	h := make(textproto.MIMEHeader)
	h.Set("Content-Disposition", `form-data; name="document"; filename="document.pdf"`)
	h.Set("Content-Type", "application/pdf")

	part, err := writer.CreatePart(h)
	if err != nil {
		log.Fatalf("error creating part: %s", err)
	}

	io.Copy(part, f)

	// write metadata
	h = make(textproto.MIMEHeader)
	h.Set("Content-Disposition", `form-data; name="metadata"`)
	h.Set("Content-Type", "application/json")

	metapart, err := writer.CreatePart(h)
	if err != nil {
		log.Fatalf("error creating metadata part: %s", err)
	}

	io.Copy(metapart, fm)

	// write out the trailer
	writer.Close()

	req, err := http.NewRequest("PUT", url.String(), body)
	if err != nil {
		log.Fatalf("error creating request to S3: %s", err)
	}

	// Keep content-type empty
	req.Header.Set("Content-type", "")

	if _, err := http.DefaultClient.Do(req); err != nil {
		log.Printf("error writing to S3: %s", err)
		os.Exit(-1)
	}

	log.Println("upload to S3 is complete")

	// poll for status from vets-api

StatusPoll:
	for {
		select {
		case <-time.After(1 * time.Minute):
			log.Println("timeout after 2 minutes")
			break StatusPoll
		default:
			status, err := c.DocumentUpload.Status(guid)
			if err != nil {
				log.Fatalf("error starting upload: %s", err)
			}

			log.Println("upload", guid, "has status", status)

			if status != "pending" && status != "uploaded" {
				break StatusPoll
			}
		}
		time.Sleep(5 * time.Second)
	}

	os.Exit(0)
}
