require 'test_helper'

class OauthCallbackTest < ActiveSupport::TestCase
  test "#auth returns a hash with hidden password and username" do
    subject = OauthCallback.new
    auth = subject.auth
    assert_equal(ENV['va_developer_client_id'], auth[:username])
    assert_match(/shhhhh/i, auth[:password])
  end

  test "#auth(false) returns a hash with username and password equal to client id and secret" do
    subject = OauthCallback.new
    auth = subject.auth(false)
    assert_equal(ENV['va_developer_client_id'], auth[:username])
    assert_equal(ENV['va_developer_client_secret'], auth[:password])
  end

  test '#post_body includes state, code, grant_type, and redirect_uri' do
    state, code = '1234567', 'SEA-OH-DEE-EE'
    subject = OauthCallback.new(state: state, code: code)
    body = subject.post_body
    assert_equal(state, body[:state])
    assert_equal(code, body[:code])
    assert_equal('authorization_code', body[:grant_type])
    assert_equal('http://localhost:3000/callback', body[:redirect_uri])
  end

  test '#response_body matches #response_body_raw, but with hidden access_token' do
    response = {
      'access_token' => 'creamy potatoes',
      'info' => 'other',
      'key3' => 'three'
    }
    subject = OauthCallback.new(response_body_raw: response)
    body = subject.response_body
    assert_match(/secret/, body.delete('access_token'))
    response.delete('access_token')
    assert_equal(response, body)
  end

  test '#fetch_access_token! sets response_body and response_code' do
    oauth_url = 'http://www.posthere.com'
    fake_body = {
      'key1' => 'one',
      'key2' => 'keto'
    }
    http_code = 500
    stub_request(:post, oauth_url).to_return(body: fake_body.to_json, status: http_code, headers: { content_type: 'application/json' })
    subject = OauthCallback.new(state: '124324523', code: '1234', oauth_url: oauth_url)

    session = {}
    subject.fetch_access_token!(session)

    assert_equal(http_code, subject.response_code)
    fake_body.each do |key, value|
      assert_equal(value, subject.response_body[key])
    end
  end

  test '#fetch_access_token! sets authentication when response is OK' do
    nonce_base = SecureRandom.base64(20)
    payload = { 'nonce' => Authentication.generate_nonce(nonce_base) }
    oauth_url = 'http://www.posthere.com'
    fake_body = {
      'access_token' => 'thisISanACCESStoken',
      'token_type' => 'bearer',
      'expires_at' => Time.zone.now.to_i,
      'id_token' => JWT.encode(payload, nil, 'none')
    }
    http_code = 200
    stub_request(:post, oauth_url).to_return(body: fake_body.to_json, status: http_code, headers: { content_type: 'application/json' })
    subject = OauthCallback.new(state: '124324523', code: '1234', oauth_url: oauth_url)

    session = { nonce_key: nonce_base }
    subject.fetch_access_token!(session)

    refute_nil subject.authentication
  end
end
