require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "#login should get login page" do
    get login_url
    assert_response :success
    assert_template :login
  end

  test "#callback should redirect to login without a code" do
    get callback_url
    assert_redirected_to login_url
    assert_match /callback page is for oauth responses/, flash[:notice]
  end

  test "#callback should redirect to login without a code and show error" do
    error, error_description = 'uh oh', 'bad times'
    get callback_url, params: { error: error, error_description: error_description }
    assert_redirected_to login_url
    assert_match error, flash[:alert]
    assert_match error_description, flash[:alert]
  end

  test "#callback should create a callback and redirect" do
    get login_url #login will set the nonce key in the session
    nonce_base = session[:nonce_key]
    payload = { 'nonce' => Authentication.generate_nonce(nonce_base) }
    oauth_body = {
      'access_token' => 'thisISanACCESStoken',
      'token_type' => 'bearer',
      'expires_at' => (Time.zone.now + 1.hour).to_i,
      'id_token' => JWT.encode(payload, nil, 'none')
    }
    stub_request(:post, "https://dev-api.va.gov/oauth2/token").
      to_return(body: oauth_body.to_json, headers: { content_type: 'application/json' })

    code, state = '12345abcdef', '123456789'
    assert_difference('OauthCallback.count', 1) do
      get callback_url, params: { code: code, state: state }
    end
    oauth_callback = OauthCallback.where(code: code, state: state, response_body_raw: oauth_body).first
    assert_redirected_to oauth_callback_url(oauth_callback)
    oauth_callback.delete
  end
end
