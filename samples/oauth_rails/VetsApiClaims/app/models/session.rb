class Session < ApplicationRecord
  def self.new_from_oauth(response)
    Session.new(process_response(response))
  end

  def expired?
    @expired ||= self.expires_at < Time.zone.now
  end

  def veteran_verification
    @veteran_verification ||= VeteranVerification.new(self.access_token)
  end

  def id_token_attributes
    # REVIEW how to decode? https://developer.va.gov/oauth#id-token
    @id_token_attributes ||= JWT.decode(self.id_token, nil, false).first
  end

  def token_refresh
    headers = {
                accept: 'application/json',
                authorization: "Bearer #{self.access_token}",
                "cache-control": 'no-cache',
                "content-type": 'application/x-www-form-urlencoded',
                refresh_token: self.refresh_token,
                redirect_uri: 'http://localhost:3000',
                scope: 'openid offline_access profile claim.read claim.write',
                grant_type: 'refresh_token'
              }
    puts headers
    response = HTTParty.post('https://dev-api.va.gov/oauth2/token', { headers: headers })
    puts response.body
    self.attributes(process_response(response))
    self.save
    self
  end

  def process_response(response)
    attributes_array = response.map do |key,value|
      clean_value =
        if key == 'expires_at'
          Time.zone.at(value)
        else
          value
        end
      [key, clean_value]
    end
    Hash[attributes_array]
  end
end
