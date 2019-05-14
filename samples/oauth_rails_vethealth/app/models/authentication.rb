class Authentication < ApplicationRecord
  serialize :id_token
  belongs_to :oauth_callback, optional: true

  attr_reader :session_errors

  def self.generate_nonce(base)
    Digest::SHA256.hexdigest(base + ENV['va_developer_client_secret'])
  end

  def self.attributes_from_oauth(response)
    attributes = response.to_h
    attributes['expires_at'] = Time.zone.at(response['expires_at'])
    attributes
  end

  def parsed_id_token
    @parsed_id_token ||= JWT.decode(self.id_token, nil, false).first
  end

  def expired?
    @expired ||= self.expires_at < Time.zone.now
  end

  def authentic?(session)
    @authentic ||= (self.parsed_id_token['nonce'] == Authentication.generate_nonce(session[:nonce_key]))
  end

  def validate_session(session)
    @authentication_errors = []
    if expired?
      @authentication_errors << { type: :expired, message: 'The session has expired.' }
    end
    unless authentic?(session)
      @authentication_errors << { type: :inauthentic, message: 'The token is not authentic!' }
    end
    @validated = true
    @authentication_errors.empty?
  end

  def valid_session?
    return @authentication_errors.empty? if @validated
    raise '#validate_session must be called first!'
  end
end
