class Session < ApplicationRecord
  serialize :id_token

  attr_reader :session_errors

  def self.generate_nonce(base)
    Digest::SHA256.hexdigest(base + ENV['va_developer_client_secret'])
  end

  def self.new_from_oauth(response)
    attributes_array = response.map do |key,value|
      clean_value =
        case key
        when 'expires_at'
          Time.zone.at(value)
        when 'id_token'
          # TODO REVIEW how to decode? https://developer.va.gov/oauth#id-token #also for other app
          JWT.decode(value, nil, false).first
        else
          value
        end
      [key, clean_value]
    end
    Session.new(Hash[attributes_array])
  end

  def expired?
    @expired ||= self.expires_at < Time.zone.now
  end

  def authentic?(session)
    @authentic ||= (self.id_token['nonce'] == Session.generate_nonce(session[:nonce_key]))
  end

  def validate_session(session)
    @session_errors = []
    if expired?
      @session_errors << { type: :expired, message: 'The session has expired.' }
    end
    unless authentic?(session)
      @session_errors << { type: :inauthentic, message: 'The token is not authentic!' }
    end
    @validated = true
    @session_errors.empty?
  end

  def valid_session?
    return @session_errors.empty? if @validated
    raise "#validate_session must be called first!"
  end
end
