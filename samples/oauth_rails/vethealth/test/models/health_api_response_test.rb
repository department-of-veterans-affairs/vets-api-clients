require 'test_helper'

class HealthApiResponseTest < ActiveSupport::TestCase
  test "initialize with a page and count for searchs" do
    stub_request(:get, /dev-api\.va\.gov/)

    subject = HealthApiResponse.new(action: :search, api_name: 'Peanuts', id: 'id1234', access_token: 'a_token')
    assert subject.page
    assert subject.count
    assert_match(/\?patient=/, subject.target)
  end

  test "initialize without a page and count for reads" do
    stub_request(:get, /dev-api\.va\.gov/)

    subject = HealthApiResponse.new(api_name: 'CrackerJacks', id: 'id4321', access_token: 'a_token')
    refute subject.page
    refute subject.count
    refute_match(/\?patient=/, subject.target)
  end

  test "initialize has a target with search param '_id' when api_name is 'Patient'" do
    stub_request(:get, /dev-api\.va\.gov/)

    id = 'id987'
    subject = HealthApiResponse.new(action: :search, api_name: 'Patient', id: id, access_token: 'a_token')
    assert_match(/\/Patient\?_id=#{id}/, subject.target)
  end

  test "#code shows the code from the api response" do
    response_code = [200,400,500].sample + rand(5)
    stub_request(:get, /dev-api\.va\.gov/).to_return(status: response_code)
    subject = HealthApiResponse.new(api_name: 'CrazyCodes', id: 'x324', access_token: 'a_token')
    assert_equal(response_code, subject.code)
  end

  test "#response_string has newlines for readability" do
    stub_request(:get, /dev-api\.va\.gov/).
      to_return(body: { key: 'value', accessor: 'result' }.to_json, headers: { content_type: 'application/json' })

    subject = HealthApiResponse.new(api_name: 'NewLines', id: 'x324', access_token: 'a_token')
    assert(subject.response_string.split("\n").count > 1)
  end

  test "#response_string has anchor tags for links to dev-api" do
    api_name = 'AnchorTags'
    body = {
      id: 1234,
      attributes: {
        link: "https://sandbox-api.va.gov/services/argonaut/v0/#{api_name}/1234"
      }
    }
    stub_request(:get, /dev-api\.va\.gov/).
      to_return(body: body.to_json, headers: { content_type: 'application/json' })

    subject = HealthApiResponse.new(api_name: api_name, id: 'x324', access_token: 'a_token')
    assert(subject.response_string.split("\n").count > 1)
  end

  test "#api_navs returns a list of name-page-counts for navigation links" do
    body = {
      link: [
        {
          relation: "first",
          url: "https://sandbox-api.va.gov/services/argonaut/v0/DiagnosticReport?patient=59&page=1&_count=10"
        },
        {
          relation: "prev",
          url: "https://sandbox-api.va.gov/services/argonaut/v0/DiagnosticReport?patient=59&page=1&_count=10"
        },
        {
          relation: "self",
          url: "https://sandbox-api.va.gov/services/argonaut/v0/DiagnosticReport?patient=59&page=2&_count=10"
        },
        {
          relation: "next",
          url: "https://sandbox-api.va.gov/services/argonaut/v0/DiagnosticReport?patient=59&page=3&_count=10"
        },
        {
          relation: "last",
          url: "https://sandbox-api.va.gov/services/argonaut/v0/DiagnosticReport?patient=59&page=4&_count=10"
        }
      ]
    }
    stub_request(:get, /dev-api\.va\.gov/).
      to_return(body: body.to_json, headers: { content_type: 'application/json' })

    navs = HealthApiResponse.new(action: :search, api_name: 'api_navs', id: 'x324', access_token: 'a_token').api_navs
    assert_equal(4, navs.count)
    refute_includes(navs.collect{ |nav| nav[:name] }, 'self')
    navs.each do |nav|
      assert_equal('10', nav[:count])
      case nav[:name]
      when 'first', 'prev'
        assert_equal('1', nav[:page])
      when 'next'
        assert_equal('3', nav[:page])
      when 'last'
        assert_equal('4', nav[:page])
      end
    end
  end

  test "#api_navs returns nil for non searchs" do
    api_name = 'NonSearch'
    stub_request(:get, /dev-api\.va\.gov/).
      to_return(body: { foo: 'bar' }.to_json, headers: { content_type: 'application/json' })

    subject = HealthApiResponse.new(api_name: 'bloorp', id: 'ididididid', access_token: 'a_token')
    assert_nil(subject.api_navs)
  end
end
