class Session < ApplicationRecord
  def self.create_from_oauth!(response)
    attributes_array = response.map do |key,value|
      clean_value =
        if key == 'expires_at'
          Time.zone.at(value)
        else
          value
        end
      [key, clean_value]
    end
    Session.create!(Hash[attributes_array])
  end

  def veteran_verification
    @veteran_verification ||= VeteranVerification.new(self.access_token)
  end

  def id_token_attributes
    # REVIEW how to decode? https://developer.va.gov/oauth#id-token
    @id_token_attributes ||= JWT.decode self.id_token, nil, false
  end
end
