require 'test_helper'

class OauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  # test "#show returns oauth callback information" do

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
end