class HealthApiResponse
  attr_reader :api_name, :target, :page, :count
  def initialize(api_name:, id:, access_token:, action: :read, page: 1, count: 10)
    @api_name, @id, @action = api_name, id, action

    case action
    when :search
      @page, @count = page, count
      @target = "https://sandbox-api.va.gov/services/fhir/v0/argonaut/data-query/#{api_name}?#{search_param_name}=#{id}&page=#{page}&_count=#{count}"
    when :read
      @page, @count = nil, nil
      @target = "https://sandbox-api.va.gov/services/fhir/v0/argonaut/data-query/#{api_name}/#{id}"
    else
      raise "action must be one of the symbols :search or :read"
    end

    @api_response = HTTParty.get(@target, headers: { Authorization: "Bearer #{access_token}" })
  end

  def code
    @api_response.code
  end

  def response_string
    # use JSON pretty_generate to add readable whitespace and gsub api links to be links within the test app
    @response_string ||= JSON.pretty_generate(@api_response.to_h).gsub(dev_api_url_regex, "<a href=\"/health_api/api_response/\\2/\\3\">\\1\/\\2\/\\3</a>")
  end

  def api_navs
    return @api_navs if @api_navs
    return nil unless (@action == :search && code == 200)
    @api_navs = []
    self_nav = nil
    @api_response['link'].each do |link|
      name, url = link['relation'], link['url']
      nav = { name: name, page: /page=(\d+)/.match(url)[1], count: /_count=(\d+)/.match(url)[1] }
      if name == 'self'
        self_nav = nav
      else
        @api_navs << nav
      end
    end
    @api_navs.delete_if { |nav| nav[:page] == "0" || (nav[:page] == self_nav[:page] && nav[:count] == self_nav[:count]) }
  end

private
  def search_param_name
    if @api_name == 'Patient'
      '_id'
    else
      'patient'
    end
  end

  def dev_api_url_regex
    # this has 3 match groups, the url base, the API, and the id
    /\"(https:\/\/sandbox-api.va.gov\/services\/argonaut\/v0)\/(\w+)\/(.+)\"/
  end
end
