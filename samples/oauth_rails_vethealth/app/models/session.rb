class Session < ApplicationRecord
  serialize :id_token

  def self.generate_nonce(base)
    Digest::SHA256.hexdigest(value + ENV['va_developer_client_secret'])
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
    @authentic ||= self.id_token['nonce'] == Session.generate_nonce(session[:nonce_key])
  end
end
