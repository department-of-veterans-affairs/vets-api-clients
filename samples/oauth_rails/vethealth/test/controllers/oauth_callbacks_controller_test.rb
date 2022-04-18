require 'test_helper'

class OauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "#show returns show_unverified_state if OauthCallback cannot verify state" do
    subject = OauthCallback.create!(state: '12321421', code: 'coda')

    get oauth_callback_url(subject.id)

    assert_template :show_unverified_state

    subject.delete
  end

  test "#show returns show_bad_oauth_request if OauthCallback has response code in the 400s" do
    error, error_description = 'bad oauth request', 'set the code in the 400s to force this error'
    code = (400..499).to_a.sample
    subject = OauthCallback.create!(
      state: '12342121342',
      code: 'kode',
      verified_state: true,
      response_code: code,
      response_body_raw: { 'error' => error, 'error_description' => error_description }
    )

    get oauth_callback_url(subject.id)

    assert_template :show_bad_oauth_request
    assert_match error, @response.body
    assert_match error_description, @response.body
    assert_match "Response Code <code>#{code}</code>", @response.body

    subject.delete
  end

  test "#show returns show_oauth_request_failure if OauthCallback has response code is not OK" do
    body = 'bad bad bad bad bad'
    code = 500
    subject = OauthCallback.create!(
      state: '12342121342',
      code: 'kode',
      verified_state: true,
      response_code: code,
      response_body_raw: body
    )

    get oauth_callback_url(subject.id)

    assert_template :show_oauth_request_failure
    assert_match body, @response.body
    assert_match "Response Code <code>#{code}</code>", @response.body

    subject.delete
  end

  test "#show the OauthCallback when response code is OK" do
    body = { 'something' => 'anything', 'abcdef' => 'ghijklm' }
    subject = OauthCallback.create!(
      state: '12342121342',
      code: 'kode',
      verified_state: true,
      response_code: 200,
      response_body_raw: body
    )

    get oauth_callback_url(subject.id)

    assert_template :show
    body.each do |key, value|
      assert_match key, @response.body
      assert_match value, @response.body
    end
    assert_match "Successfully authenticated", @response.body

    subject.delete
  end

  def oauth_login(code)
    get login_url
    nonce_base = session[:nonce_key]
    payload = { 'nonce' => Authentication.generate_nonce(nonce_base) }
    oauth_body = {
      'access_token' => 'thisISanACCESStoken',
      'expires_at' => (Time.zone.now + 1.hour).to_i,
      'id_token' => JWT.encode(payload, nil, 'none')
    }
    stub_request(:post, "https://sandbox-api.va.gov/oauth2/token").
      to_return(body: oauth_body.to_json, headers: { content_type: 'application/json' })

    get callback_url, params: { code: code, state: session[:login_time] }
  end

  test "#show Authentication when authentication is present for OauthCallback" do
    code = 'good authentication'
    oauth_login(code)
    subject = OauthCallback.find_by_code(code)

    get oauth_callback_url(subject.id)

    assert_template :show
    assert_match authentication_path(subject.authentication.id), @response.body

    subject.authentication.delete
    subject.delete
  end

  test "#show Authentication errors when authentication is present for OauthCallback but session does not match" do
    code = 'bad authentication'
    oauth_login(code)
    subject = OauthCallback.find_by_code(code)

    subject.authentication.expires_at = (Time.zone.now - 1.hour)
    subject.authentication.save!

    get oauth_callback_url(subject.id)

    assert_template :show
    assert_match(/The session does not match/, @response.body)
    assert_match(/The session has expired/, @response.body)

    subject.authentication.delete
    subject.delete
  end
end