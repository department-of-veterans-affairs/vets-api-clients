class Session < ApplicationRecord
  serialize :id_token

  attr_reader :session_errors

  def self.generate_nonce(base)
    Digest::SHA256.hexdigest(value + ENV['va_developer_client_secret'])
  end

  def self.new_from_oauth(response)
    # TODO path for creating an empty session because of error?
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

  def valid_session?(session)
    return @session_errors.empty? if @validated
    @session_errors = []
    if expired?
      @session_errors << { type: :expired, message: 'The session has expired.' }
    end
    if authentic?(session)
      @session_errors << { type: :inauthentic, message: 'The token is not authentic!' }
    end
    @validated = true
    @session_errors.empty?
  end
end
