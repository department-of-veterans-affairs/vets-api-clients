class HealthApiResponse
  attr_reader :api_name, :target, :page, :count
  def initialize(api_name:, id:, access_token:, action: :read, page: 1, count: 10)
    @api_name, @id, @action = api_name, id, action
    if action == :search
      @page, @count = page, count
      search_param = (api_name == 'Patient' ? '_id' : 'patient')
      @target = "https://dev-api.va.gov/services/argonaut/v0/#{api_name}?#{search_param}=#{id}&page=#{page}&_count=#{count}"
    elsif action == :read
      @page, @count = nil, nil
      @target = "https://dev-api.va.gov/services/argonaut/v0/#{api_name}/#{id}"
    else
      raise "action must be one of the symbols :search or :read"
    end
    @api_response = HTTParty.get(@target, headers: { Authorization: "Bearer #{access_token}" })
  end

  def code
    @api_response.code
  end

  def response_string
    return @response_string if @response_string
    # use JSON pretty_generate to add readable whitespace and gsub api links to be links with the test app
    @response_string = JSON.pretty_generate(@api_response.to_h).gsub(/\"(https:\/\/dev-api.va.gov\/services\/argonaut\/v0)\/(\w+)\/(.+)\"/, "<a href=\"/health_api/api_response/\\2/\\3\">\\1\/\\2\/\\3</a>")
    @response_string
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
    @api_navs
  end
end