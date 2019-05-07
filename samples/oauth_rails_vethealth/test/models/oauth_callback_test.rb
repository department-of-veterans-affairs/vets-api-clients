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

  test '#fetch_access_token! sets code and state' do
    skip
  end
end
