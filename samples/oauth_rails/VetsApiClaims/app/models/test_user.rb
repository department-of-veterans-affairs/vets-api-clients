class TestUser < ApplicationRecord
  has_many :test_veterans

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

  def headers(token, user)
    {
     'X-VA-SSN' => user.ssn,
     'X-VA-User' => 'mytestapp',
     'X-VA-First-Name' => user.first_name,
     'X-VA-Last-Name' => user.last_name,
     'X-VA-Birth-Date' => user.birth_date.to_s,
     'X-Consumer-Username' => 'oddball',
     'Authorization' => "Bearer #{token}"
    }
  end

  def self.claims(session)
    response = RestClient.get("#{ENV['vets_api_url']}/services/claims/v1/claims", {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def claims_for(user, session)
    response = RestClient.get("#{ENV['vets_api_url']}/services/claims/v1/claims", headers(session.access_token, user))
    JSON.parse(response&.body)['data']
  end

  def self.claim(claim_id, session)
    response = RestClient.get("#{ENV['vets_api_url']}/services/claims/v1/claims/#{claim_id}", {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def claim_for(claim_id, user, session)
    response = RestClient.get("#{ENV['vets_api_url']}/services/claims/v1/claims/#{claim_id}", headers(session.access_token, user))
    JSON.parse(response&.body)['data']
  end

  def active_itf(session)
    response = RestClient.get("#{ENV['vets_api_url']}/services/claims/v1/forms/0966/active?type=compensation", {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def active_itf_for(user, session)
    response = RestClient.get("#{ENV['vets_api_url']}/services/claims/v1/forms/0966/active?type=compensation", headers(session.access_token, user))
    JSON.parse(response&.body)['data']
  end

  def submit_itf(session)
    response = RestClient.post("#{ENV['vets_api_url']}/services/claims/v1/forms/0966", submit_type, {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def submit_itf_for(user, session)
    response = RestClient.post("#{ENV['vets_api_url']}/services/claims/v1/forms/0966", submit_type, headers(session.access_token, user))
    JSON.parse(response&.body)['data']
  end

  def submit_type
    {data: { attributes: { type: 'compensation'} } }.to_json
  end
end
