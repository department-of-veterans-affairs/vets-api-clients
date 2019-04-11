class Session < ApplicationRecord
  def veteran_verification
    @veteran_verification ||= VeteranVerification.new(self.access_token)
  end

  def id_token_attributes
    # REVIEW how to decode? https://developer.va.gov/oauth#id-token
    @id_token_attributes ||= JWT.decode self.id_token, nil, false
  end
end
