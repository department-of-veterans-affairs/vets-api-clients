package main // import "github.com/department-of-veterans-affairs/vets-api-clients/services/vba_documents/go"

import (
	"log"
	"net/url"
	"os"

	vetsapi "github.com/department-of-veterans-affairs/vets-api-clients/services/vba_documents/go"
)

// api.vets.gov sample client

func main() {
	key := os.Getenv("VETS_API_TOKEN")
	if key == "" {
		log.Fatalln("VETS_API_TOKEN is unset. Please provide your API key as an environment variable")
		os.Exit(-1)
	}

	c := vetsapi.NewClient(nil)
	c.Key = key

	// host override
	host := os.Getenv("VETS_API_URL")
	if host != "" {
		u, err := url.Parse(host)
		if err != nil {
			log.Fatalln("VETS_API_URL is invalid: ", err)
		}
		c.Url = u
	}

	// try a ping
	if err := c.Meta.Ping(); err != nil {
		log.Fatalln("error pinging:", err)
	}

	log.Println("ping was successful")

	// fetch version data
	version, err := c.Meta.Version()
	if err != nil {
		log.Fatalf("error fetching version data: %s", err)
	}

	log.Println("fetched version data:", version)
	os.Exit(0)
}
