require 'test_helper'

class AuthenticationsControllerTest < ActionDispatch::IntegrationTest
  def oauth_login
    get login_url
    nonce_base = session[:nonce_key]
    payload = { 'nonce' => Authentication.generate_nonce(nonce_base) }
    oauth_body = {
      'access_token' => 'thisISanACCESStoken',
      'token_type' => 'bearer',
      'expires_at' => (Time.zone.now + 1.hour).to_i,
      'id_token' => JWT.encode(payload, nil, 'none'),
      'scope' => 'some scope values',
      'patient' => 'health_api_controller_test_patient'
    }
    stub_request(:post, "https://dev-api.va.gov/oauth2/token").
      to_return(body: oauth_body.to_json, headers: { content_type: 'application/json' })

    code, state = '12345abcdef', '123456789'
    get callback_url, params: { code: code, state: state }
  end

  test 'redirect to login without an authentication in session' do
    get authentication_url(100)
    assert_redirected_to login_url
  end

  test '#show gives authenication details' do
    oauth_login
    get authentication_url(session[:id])

    assert_response :success
    assert_template :show
    assert_match('Current Authentication Information', @response.body)

    authentication = Authentication.find(session[:id])
    refute_match(authentication.access_token, @response.body)
  end
end