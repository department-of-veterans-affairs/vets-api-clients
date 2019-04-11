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

  def disability_rating
    response = get('disability_rating')
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
  class ResultsUnavailable < StandardError
    attr_reader :api_errors
    def initialize(msg, errors)
      @api_errors = errors
      super(msg)
    end
  end

  def get(endpoint, version: 0)
    response = HTTParty.get("https://#{@env_prefix}api.va.gov/services/veteran_verification/v#{version}/#{endpoint}", { headers: @authed_header })
    return response if response.code == 200
    raise ResultsUnavailable.new("Accessing #{endpoint} API returned an #{Rack::Utils::HTTP_STATUS_CODES[response.code]}", response['errors'])
  end
end