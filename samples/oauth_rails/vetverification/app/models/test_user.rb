class TestUser < ApplicationRecord

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

  def self.claims(session)
    response = RestClient.get("#{Figaro.env.vets_api_url}/services/claims/v1/claims", {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def self.claim(claim_id, session)
    response = RestClient.get("#{Figaro.env.vets_api_url}/services/claims/v1/claims/#{claim_id}", {'Authorization' => "Bearer #{session.access_token}"})
    JSON.parse(response&.body)['data']
  end

  def test_veterans
    TestVeteran.where(poa: self.poa)
  end
end
