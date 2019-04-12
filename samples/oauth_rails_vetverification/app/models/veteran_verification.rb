class VeteranVerification
  def initialize(access_token)
    @authed_header = { Authorization: "Bearer #{access_token}" }
    @env_prefix = 'dev-' # TODO support other environments
  end

  def confirmed?
    response = get('status')
    return response if response.is_a? BadResponse
    response['data']['attributes']['veteran_status'] == 'confirmed'
  end

  def service_histories
    response = get('service_history')
    return response if response.is_a? BadResponse
    response['data'].collect { |data| ServiceHistory.new(data) }
  end

  def disability_rating
    response = get('disability_rating')
    return response if response.is_a? BadResponse
    d_rating = {}
    response['data']['attributes'].each do |key,value|
      d_rating[key] =
        if key == 'effective_date'
          Time.zone.parse(value)
        else
          value
        end
    end
    d_rating
  end

private
  class BadResponse
    attr_reader :message, :api_errors
    def initialize(message, errors)
      @api_errors = errors
      @message = message
    end
  end

  def get(endpoint, version: 0)
    response = HTTParty.get("https://#{@env_prefix}api.va.gov/services/veteran_verification/v#{version}/#{endpoint}", { headers: @authed_header })
    return response if response.code == 200
    BadResponse.new("Accessing #{endpoint} API returned an #{Rack::Utils::HTTP_STATUS_CODES[response.code]}", response['errors'])
  end
end