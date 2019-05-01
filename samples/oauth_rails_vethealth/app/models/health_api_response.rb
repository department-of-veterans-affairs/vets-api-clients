class HealthApiResponse
  attr_reader :target
  def initializer(api_name:, id:, access_token:, action: :read, page: 1, count: 10)
    @api_name, @id, @action, @page, @count = api_name, id, action, page, count
    if action == :search
      search_param = (api_name == 'Patient' ? '_id' : 'patient'
      @target = "https://dev-api.va.gov/services/argonaut/v0/#{api_name}?#{search_param}=#{id}&page=#{page}&_count=#{count}"
    elsif action == :read
      @target = "https://dev-api.va.gov/services/argonaut/v0/#{api_name}/#{id}"
    else
      raise "action must be one of the symbols :search or :read"
    end
    @api_response = HTTParty.get(@target, headers: { Authorization: "Bearer #{access_token}" })
  end

  def code
    # TODO review: do we want to just method_missing to @api_response?
    @api_response.code
  end

  def response_string
    return @response_string if @response_string
    @response_string = JSON.pretty_generate(@api_response.to_h)
    
    if @action == :search
      # replace all the "fullURL"s with links to api_by_param for those individual requests
      @response_string.gsub!(/\"(https:\/\/dev-api.va.gov\/services\/argonaut\/v0\/#{@api_name})\/(.+)\"/, "<a href=\"/health_api/api_response/#{@api_name}/\\2\">\\1\/\\2</a>")
    end

    if @api_name == 'MedicationOrder'
      # link to medication API
      @response_string.gsub!(/\"(https:\/\/dev-api.va.gov\/services\/argonaut\/v0\/Medication)\/(.+)\"/, "<a href=\"/health_api/api_response/Medication/\\2\">\\1\/\\2</a>")
    end
  end

  def api_navs
    return @api_navs if @api_navs
    return nil if @action == :read
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
    # TODO delete first/last if same as prev/next?
    @api_navs
  end
end