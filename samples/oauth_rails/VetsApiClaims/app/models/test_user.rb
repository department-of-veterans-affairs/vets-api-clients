class TestUser < ApplicationRecord

  def self.stub_headers
    {
     'X-VA-SSN' => '796130115',
     'X-VA-User' => 'mytestapp',
     'X-VA-First-Name' => 'Tamara',
     'X-VA-Last-Name' => 'Ellis',
     'X-VA-Birth-Date' => '1967-06-19',
     'X-VA-EDIPI' => '1005490754',
     'X-Consumer-Username' => 'oddball'
    }
  end

  def headers(token)
    {
     'X-VA-SSN' => ssn,
     'X-VA-User' => 'mytestapp',
     'X-VA-First-Name' => first_name,
     'X-VA-Last-Name' => last_name,
     'X-VA-Birth-Date' => birth_date.to_s,
     'X-VA-EDIPI' => edipi,
     'X-Consumer-Username' => 'oddball',
     'Authorization' => "Bearer #{token}"
    }
  end

  def claims_for(user, session)
    response = RestClient.get("#{Figaro.env.vets_api_url}/services/claims/v1/claims", headers(session.access_token))
    JSON.parse(response&.body)['data']
  end

  def test_veterans
    TestVeteran.where(poa: self.poa)
  end

  def active_itf(session)
    response = RestClient.get("#{Figaro.env.vets_api_url}/services/claims/v1/forms/0966/active?type=compensation", {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def submit_itf(session)
    response = RestClient.post("#{Figaro.env.vets_api_url}/services/claims/v1/forms/0966", submit_type, {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def submit_type
    {data: { attributes: { type: 'compensation'} } }.to_json
  end

  def self.claims(session)
    response = RestClient.get("#{Figaro.env.vets_api_url}/services/claims/v1/claims", {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def self.claim(claim_id, session)
    response = RestClient.get("#{Figaro.env.vets_api_url}/services/claims/v1/claims/#{claim_id}", {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

end
