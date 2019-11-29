# frozen_string_literal: true

class BaseClaimsService
  BASE_PATH = "#{Figaro.env.vets_api_url}/services/claims/v1"

  def initialize(token, veteran = nil)
    @token = token
    @veteran = veteran
  end

  def self.stub_headers
    {
      'X-VA-SSN' => '796130115',
      'X-VA-User' => 'mytestapp',
      'X-VA-First-Name' => 'Tamara',
      'X-VA-Last-Name' => 'Ellis',
      'X-VA-Birth-Date' => '1967-06-19',
      'X-Consumer-Username' => 'oddball'
    }
  end

  def headers(user)
    {
      'X-VA-SSN' => user.ssn,
      'X-VA-User' => 'mytestapp',
      'X-VA-First-Name' => user.first_name,
      'X-VA-Last-Name' => user.last_name,
      'X-VA-Birth-Date' => user.birth_date.to_s,
      'X-Consumer-Username' => 'oddball',
      'Authorization' => "Bearer #{@token}"
    }
  end

  def get_data(response)
    JSON.parse(response&.body)['data']
  end

  def get(path, request_headers = nil)
    get_data(RestClient.get(path, request_headers))
  end

  def post(path, params, request_headers)
    get_data(RestClient.post(path, params, request_headers))
  end

  def authorization_header
    { 'Authorization' => "Bearer #{@token}" }
  end
end
