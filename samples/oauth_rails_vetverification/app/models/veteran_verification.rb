class VeteranVerification
  attr_reader :errors

  def initialize(access_token)
    @authed_header = { Authorization: "Bearer #{access_token}" }
    @env_prefix = 'dev-' # TODO support other environments
    @errors = []
  end

  def confirmed_status
    return @confirmed_status unless @confirmed_status.nil?
    response = get('status')
    return nil if response.code != 200
    @confirmed_status = (response['data']['attributes']['veteran_status'] == 'confirmed')
  end

  def service_histories
    return @service_histories if @service_histories
    response = get('service_history')
    @service_histories =
      if response.code == 200
        response['data'].collect { |data| ServiceHistory.new(data) }
      else
        []
      end
  end

  def disability_ratings
    return @disability_ratings if @disability_ratings
    response = get('disability_rating', allow: [402])
    return nil if response.code != 200

    ratings = []
    response['data'].each do |rating|
      modified_rating = {}
      rating['attributes'].each do |key,value|
        modified_rating[key] =
          if key == 'effective_date'
            Time.zone.parse(value)
          else
            value
          end
      end
      ratings << modified_rating
    end
    @disability_ratings = ratings
  end

private
  def get(endpoint, version: 0, allow: [])
    response = HTTParty.get("https://#{@env_prefix}api.va.gov/services/veteran_verification/v#{version}/#{endpoint}", { headers: @authed_header })
    if response.code != 200 && allow.exclude?(response.code)
      @errors << {message: "Accessing #{endpoint} API returned #{Rack::Utils::HTTP_STATUS_CODES[response.code]}", error_objects: response['errors']}
    end
    response
  end
end