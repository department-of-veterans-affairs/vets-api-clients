package client

type versionJson struct {
	Version string `json:"git_revision"`
}

// Return the version of the Vets API
func (v *MetaService) Version() (string, error) {
	req, err := v.client.NewRequest("GET", "/services/meta/v0/version", nil)
	if err != nil {
		return "", err
	}

	var j versionJson
	_, err = v.client.Do(req, &j)
	if err != nil {
		return "", err
	}

	return j.Version, nil
}

// Ping the Vets API
func (v *MetaService) Ping() error {
	req, err := v.client.NewRequest("GET", "/services/meta/v0/ping", nil)
	if err != nil {
		return err
	}

	_, err = v.client.Do(req, nil)
	if err != nil {
		return err
	}

	return nil
}
