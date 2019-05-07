require 'test_helper'

class HealthApiResponseTest < ActiveSupport::TestCase
  test "initialize with a page and count for searchs" do
    stub_request(:get, /dev-api\.va\.gov/).to_return(status: 200)

    response = HealthApiResponse.new(action: :search, api_name: 'Peanuts', id: 'id1234', access_token: 'a_token')
    assert response.page
    assert response.count
    assert_match(/\?patient=/, response.target)
  end

  test "initialize without a page and count for reads" do
    stub_request(:get, /dev-api\.va\.gov/).to_return(status: 200)

    response = HealthApiResponse.new(api_name: 'CrackerJacks', id: 'id4321', access_token: 'a_token')
    refute response.page
    refute response.count
    refute_match(/\?patient=/, response.target)
  end

  test "initialize has a target with search param '_id' when api_name is 'Patient'" do
    stub_request(:get, /dev-api\.va\.gov/).to_return(status: 200)

    id = 'id987'
    response = HealthApiResponse.new(action: :search, api_name: 'Patient', id: id, access_token: 'a_token')
    assert_match(/\/Patient\?_id=#{id}/, response.target)
  end
end
