class VeteranVerification
  def initialize(access_token)
    @authed_header = { Authorization: "Bearer #{access_token}" }
    @env_prefix = 'dev-' # TODO support other environments
  end

  def confirmed?
    response = get('status')
    response['data']['attributes']['veteran_status'] == 'confirmed'
  end

  def service_histories
    response = get('service_history')
    response['data'].collect { |data| ServiceHistory.new(data) }
  end

private
  def get(endpoint, version: 0)
    HTTParty.get("https://#{@env_prefix}api.va.gov/services/veteran_verification/v#{version}/#{endpoint}", { headers: @authed_header })
  end
end