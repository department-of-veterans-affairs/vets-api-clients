class VeteranVerification
  def initialize(access_token)
    @token = access_token
  end

  def confirmed?
    response = HTTParty.get('https://dev-api.va.gov/services/veteran_verification/v0/status', { headers: { Authorization: "Bearer #{@token}" } })
    response['data']['attributes']['veteran_status'] == 'confirmed'
  end
end