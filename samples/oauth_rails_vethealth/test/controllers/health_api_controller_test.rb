require 'test_helper'

class HealthApiControllerTest < ActionDispatch::IntegrationTest
  def oauth_login
    get login_url
    nonce_base = session[:nonce_key]
    payload = { 'nonce' => Authentication.generate_nonce(nonce_base) }
    oauth_body = {
      'access_token' => 'thisISanACCESStoken',
      'token_type' => 'bearer',
      'expires_at' => (Time.zone.now + 1.hour).to_i,
      'id_token' => JWT.encode(payload, nil, 'none'),
      'patient' => 'health_api_controller_test_patient'
    }
    stub_request(:post, "https://dev-api.va.gov/oauth2/token").
      to_return(body: oauth_body.to_json, headers: { content_type: 'application/json' })

    code, state = '12345abcdef', '123456789'
    get callback_url, params: { code: code, state: state }
  end

  test 'all pages should redirect to login without an authentication in session' do
    get index_url
    assert_redirected_to login_url

    get search_api_url('ApiName')
    assert_redirected_to login_url

    get '/health_api/api_response/ApiName/2'
    assert_redirected_to login_url
  end

  test "#index should show index page" do
    oauth_login

    get index_url
    assert_response :success
    assert_template :index
  end

  test "#search_api_by_param should show search_api_by_param page" do
    oauth_login

    status, key, value = 200, 'tests', 'work'
    stub_request(:get, /https:\/\/dev-api.va.gov\/services\/argonaut\/v0\//).
      to_return(status: status, body: { key => value, 'link' => [] }.to_json, headers: { content_type: 'application/json' })

    api_name = 'Horticulture'
    get search_api_url(api_name)
    assert_response :success
    assert_template :search_api_by_param
    assert_match api_name, @response.body
    assert_match key, @response.body
    assert_match value, @response.body
  end
end
