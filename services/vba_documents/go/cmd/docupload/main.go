package main // import "github.com/department-of-veterans-affairs/vets-api-clients/services/vba_documents/go"

import (
	"bytes"
	"flag"
	"io"
	"io/ioutil"
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

var (
	docPath, attachmentPath, metadataPath string
	dryRun                                bool
)

func init() {
	flag.StringVar(&docPath, "doc", "sample.pdf", "path to PDF to upload")
	flag.StringVar(&metadataPath, "meta", "metadata.json", "path to metadata file (as JSON)")
	flag.StringVar(&attachmentPath, "attach", "sample.pdf", "(optional) path to attachment")
	flag.BoolVar(&dryRun, "dryrun", false, "if true, do not perform actual upload, just output action that would be performed")
}

func main() {
	flag.Parse()

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
			log.Println("VETS_API_URL is invalid: ", err)
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

	log.Println("starting upload to s3 for doc", guid, "signed url is", url)

	f, err := os.Open(docPath)
	if err != nil {
		log.Fatalf("error opening file: %s", err)
	}
	defer f.Close()

	fm, err := os.Open(metadataPath)
	if err != nil {
		log.Fatalf("error metadata file: %s", err)
	}
	defer fm.Close()

	var fa *os.File
	if attachmentPath != "" {
		var err error
		fa, err = os.Open(attachmentPath)
		if err != nil {
			log.Fatalf("error attachment file: %s", err)
		}
	}
	defer fa.Close()

	// create a multipart upload
	body := new(bytes.Buffer)
	mpwriter := multipart.NewWriter(body)

	// CreateFormPart doesn't set the MIME type of the part
	// so we use CreatePart instead, allowing custom content-type
	h := make(textproto.MIMEHeader)
	h.Set("Content-Disposition", `form-data; name="content"; filename="content"`)
	h.Set("Content-Type", "application/pdf")

	part, err := mpwriter.CreatePart(h)
	if err != nil {
		log.Fatalf("error creating part: %s", err)
	}

	if _, err := io.Copy(part, f); err != nil {
		log.Fatalln("error writing file:", err)
	}

	// write metadata
	h = make(textproto.MIMEHeader)
	h.Set("Content-Disposition", `form-data; name="metadata"`)
	h.Set("Content-Type", "application/json")

	metapart, err := mpwriter.CreatePart(h)
	if err != nil {
		log.Fatalf("error creating metadata part: %s", err)
	}

	if _, err := io.Copy(metapart, fm); err != nil {
		log.Fatalln("error writing metadata:", err)
	}

	// write attachment if present
	if attachmentPath != "" {
		h = make(textproto.MIMEHeader)
		h.Set("Content-Disposition", `form-data; name="attachment1"; filename="attachment1"`)
		h.Set("Content-Type", "application/pdf")

		attachpart, err := mpwriter.CreatePart(h)
		if err != nil {
			log.Fatalf("error creating attachment part: %s", err)
		}

		if _, err := io.Copy(attachpart, fa); err != nil {
			log.Fatalln("error writing attachment:", err)
		}
	}

	// write out the trailer
	mpwriter.Close()

	req, err := http.NewRequest("PUT", url.String(), body)
	if err != nil {
		log.Fatalf("error creating request to S3: %s", err)
	}

	// Keep content-type empty
	req.Header.Set("Content-type", "")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		log.Fatalf("error writing to S3: %s", err)
	}

	if resp.StatusCode >= 400 {
		log.Println(resp)
		b, _ := ioutil.ReadAll(resp.Body)
		defer resp.Body.Close()
		log.Println(string(b))
		log.Fatalln("upload to S3 failed")
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
