class Authentication < ApplicationRecord
  serialize :id_token
  belongs_to :oauth_callback, optional: true
  
  attr_accessor :expires_in
  attr_reader :authentication_errors

  def self.generate_nonce(base)
    Digest::SHA256.hexdigest(base.to_s + ENV['va_developer_client_secret'])
  end

  def self.attributes_from_oauth(response)
    response['expires_at'] = response['expires_in'].seconds.from_now
    attributes = response.to_h
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

  # ensure session corresponds to this Authentication
  def validate_session(session)
    return @authentication_errors.empty? unless @authentication_errors.nil?
    @authentication_errors = []
    if expired?
      # this session should be expired because this Authentication is
      @authentication_errors << { type: :expired, message: 'The session has expired.' }
    end
    unless authentic?(session)
      # this session is not authentic because it's nonce_base does not correspond to this authentication
      @authentication_errors << { type: :inauthentic, message: 'The token is not authentic!' }
    end
    # this is valid if there were no errors found
    @authentication_errors.empty?
  end
end
