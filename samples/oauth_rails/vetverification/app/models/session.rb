class Session < ApplicationRecord

  def self.new_from_oauth(response)
    response['expires_in'] = response['expires_in'].seconds.from_now
    attributes = response.to_h
    attributes
    Session.new(Hash[attributes])
  end

  def expired?
    @expired ||= self.expires_in < Time.zone.now
  end

  def veteran_verification
    @veteran_verification ||= VeteranVerification.new(self.access_token)
  end

  def id_token_attributes
    # REVIEW how to decode? https://developer.va.gov/oauth#id-token
    @id_token_attributes ||= JWT.decode(self.id_token, nil, false).first
  end
end
