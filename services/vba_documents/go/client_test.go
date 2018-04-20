package client

import (
	"fmt"
	"net/http"
	"net/http/httptest"
	"net/url"
	"testing"
)

func TestNewClient(t *testing.T) {
	c := NewClient(nil)

	if c == nil {
		t.Fatal("expected non-nil client")
	}
}

func TestNewClientWithPassedInClient(t *testing.T) {
	hc := http.Client{}

	c := NewClient(&hc)

	if c.client != &hc {
		t.Fatal("expected client to use provided http.Client")
	}
}

func TestClientSetsHeaders(t *testing.T) {
	c := testClient()
	req, _ := c.NewRequest("GET", "/foo", nil)

	if c.Key == "" {
		t.Error("expected a non-empty key value")
	}

	if v := req.Header.Get(TokenHeader); v != c.Key {
		t.Error("token header is", v, "expected", c.Key)
	}

	if v := req.Header.Get("user-agent"); v != UserAgent {
		t.Error("user agent header is", v, "expected", UserAgent)
	}

}

func TestCanPerformRequest(t *testing.T) {
	msg := `{"msg": "hello, world!"}`

	// src: https://golang.org/pkg/net/http/httptest/#example_Server
	ts := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintln(w, msg)
	}))
	defer ts.Close()

	c := testClient()
	c.Url, _ = url.Parse(ts.URL)

	req, err := c.NewRequest("GET", ts.URL, nil)
	if err != nil {
		t.Fatal(err)
	}

	var v struct {
		Msg string `json:"msg"`
	}

	resp, err := c.Do(req, &v)
	if err != nil {
		t.Fatal(err)
	}

	if code := resp.StatusCode; code != 200 {
		t.Error("expected 200 status, got", code)
	}

	if m := v.Msg; m != "hello, world!" {
		t.Error("expected unmarshalled value to be 'hello, world!' but got", m)
	}
}

func testClient() *VetsAPIClient {
	key := "1234"
	c := NewClient(nil)
	c.Key = key

	return c
}
