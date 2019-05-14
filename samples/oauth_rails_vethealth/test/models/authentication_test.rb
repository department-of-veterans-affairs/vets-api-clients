require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  test '.attributes_from_oauth returns a hash with expires_at as a Time.zone' do
    response_body = {
      expires_at: Time.zone.now.to_i,
      something: 'just a value'
    }
    url = 'https://dev-api.va.gov/oauth2/token'
    stub_request(:post, url).
      to_return(body: response_body.to_json, headers: { content_type: 'application/json' })
    httparty_response = HTTParty.post(url, { body: {matters: false}.to_json } )

    attributes = Authentication.attributes_from_oauth(httparty_response)
    assert attributes.is_a?(Hash)
    assert attributes['expires_at'].is_a?(ActiveSupport::TimeWithZone)
  end
  test "#parsed_id_token returns a hash" do
    payload = { 'key' => 'value', 'some' => 'thing' }
    subject = Authentication.new(id_token: JWT.encode(payload, nil, 'none'))
    assert_equal(payload, subject.parsed_id_token)
  end

  test "#expired? is false when expires_at is in the future" do
    subject = Authentication.new(expires_at: Time.zone.now + 10.minutes)
    refute subject.expired?
  end

  test "#expired? is true when expires_at is in the past" do
    subject = Authentication.new(expires_at: Time.zone.now - 10.minutes)
    assert subject.expired?
  end

  test '#authentic? is true when the nonce can be generatesd from the session' do
    base = SecureRandom.base64(20)
    payload = { 'nonce' => Authentication.generate_nonce(base) }
    subject = Authentication.new(id_token: JWT.encode(payload, nil, 'none'))
    fake_session = { nonce_key: base }
    assert subject.authentic?(fake_session)
  end

  test '#authentic? is false when the nonce does not match the key in the session' do
    base = SecureRandom.base64(20)
    payload = { 'nonce' => 'SUPER_FAKE_NONCE_THAT_FAILS' }
    subject = Authentication.new(id_token: JWT.encode(payload, nil, 'none'))
    fake_session = { nonce_key: base }
    refute subject.authentic?(fake_session)
  end

  test '#valid_session? raises an exception if #validate_session is not run' do
    subject = Authentication.new
    exception = assert_raises { subject.valid_session? }
    assert_equal('#validate_session must be called first!', exception.message)
  end

  test '#valid_session? is true when #validate_session is true' do
    base = SecureRandom.base64(20)
    payload = { 'nonce' => Authentication.generate_nonce(base) }
    subject = Authentication.new(
      expires_at: Time.zone.now + 10.minutes,
      id_token: JWT.encode(payload, nil, 'none')
    )
    fake_session = { nonce_key: base }
    assert subject.validate_session(fake_session)
    assert subject.valid_session?
  end

  test '#valid_session? is false when #validate_session is false with a bad nonce' do
    base = SecureRandom.base64(20)
    payload = { 'nonce' => 'SUPER_FAKE_NONCE_THAT_FAILS' }
    subject = Authentication.new(
      expires_at: Time.zone.now + 10.minutes,
      id_token: JWT.encode(payload, nil, 'none')
    )
    fake_session = { nonce_key: base }
    refute subject.validate_session(fake_session)
    refute subject.valid_session?
  end

  test '#valid_session? is false when #validate_session is false with a bad expires_at' do
    base = SecureRandom.base64(20)
    payload = { 'nonce' => Authentication.generate_nonce(base) }
    subject = Authentication.new(
      expires_at: Time.zone.now - 10.minutes,
      id_token: JWT.encode(payload, nil, 'none')
    )
    fake_session = { nonce_key: base }
    refute subject.validate_session(fake_session)
    refute subject.valid_session?
  end
end
