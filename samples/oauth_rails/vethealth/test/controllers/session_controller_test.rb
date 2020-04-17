require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "#login should get login page" do
    get login_url
    assert_response :success
    assert_template :login
  end

  test "#callback should redirect to logout without a code" do
    get callback_url
    assert_redirected_to logout_url
    assert_match /callback page is for oauth responses/, flash[:notice]
  end

  test "#callback should redirect to logout without a code and show error" do
    error, error_description = 'uh oh', 'bad times'
    get callback_url, params: { error: error, error_description: error_description }
    assert_redirected_to logout_url
    assert_match error, flash[:alert]
    assert_match error_description, flash[:alert]
  end

  test "#callback should create a callback, set an Authentication id in session, and redirect" do
    get login_url #login will set the nonce key in the session
    nonce_base = session[:nonce_key]
    payload = { 'nonce' => Authentication.generate_nonce(nonce_base) }
    oauth_body = {
      'access_token' => 'thisISanACCESStoken',
      'token_type' => 'bearer',
      'expires_at' => (Time.zone.now + 1.hour).to_i,
      'id_token' => JWT.encode(payload, nil, 'none')
    }
    stub_request(:post, "https://sandbox-api.va.gov/oauth2/token").
      to_return(body: oauth_body.to_json, headers: { content_type: 'application/json' })

    code, state = '12345abcdef', '123456789'
    assert_difference('OauthCallback.count', 1) do
      get callback_url, params: { code: code, state: state }
    end
    oauth_callback = OauthCallback.where(code: code, state: state, response_body_raw: oauth_body).first
    assert_redirected_to oauth_callback_url(oauth_callback)
    assert_equal(session[:id], oauth_callback.authentication.id)
    oauth_callback.authentication.delete
    oauth_callback.delete
  end

  test "#logout redirects to the login page" do
    get logout_url
    assert_redirected_to login_url
  end

  test '#logout deletes session keys used for authentication' do
    ### login logic ###
    get login_url
    nonce_base = session[:nonce_key]
    oauth_body = {
      'access_token' => 'thisISanACCESStoken',
      'token_type' => 'bearer',
      'expires_at' => (Time.zone.now + 1.hour).to_i,
      'id_token' => JWT.encode({ 'nonce' => Authentication.generate_nonce(nonce_base) }, nil, 'none'),
      'patient' => 'health_api_controller_test_patient'
    }
    stub_request(:post, "https://sandbox-api.va.gov/oauth2/token").
      to_return(body: oauth_body.to_json, headers: { content_type: 'application/json' })

    get callback_url, params: { code: 'logout test', state: '12345676453242345' }
    ### successfully logged in and set session ###
    get logout_url
    assert_nil session[:login_time]
    assert_nil session[:nonce_key]
    assert_nil session[:id]
  end
end
