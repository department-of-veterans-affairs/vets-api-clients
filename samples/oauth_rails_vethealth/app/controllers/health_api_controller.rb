class HealthApiController < ApplicationController
  before_action :require_auth

  def index
    @apis = [
      {text: 'Allergy Intolerance', uri_segment: 'AllergyIntolerance', search_param: 'patient'},
      {text: 'Condition', uri_segment: 'Condition', search_param: 'patient'},
      {text: 'Diagnostic Report', uri_segment: 'DiagnosticReport', search_param: 'patient'},
      {text: 'Immunization', uri_segment: 'Immunization', search_param: 'patient'},
      # {text: 'Medication', uri_segment: 'Medication'}, #has no search # TODO show this
      {text: 'Medication Order', uri_segment: 'MedicationOrder', search_param: 'patient'},
      {text: 'Medication Statement', uri_segment: 'MedicationStatement', search_param: 'patient'},
      {text: 'Observation', uri_segment: 'Observation', search_param: 'patient'},
      {text: 'Patient', uri_segment: 'Patient', search_param: '_id'},
      {text: 'Procedure', uri_segment: 'Procedure', search_param: 'patient'}
    ]
  end

  def api_by_param
    @target = "https://dev-api.va.gov/services/argonaut/v0/#{params[:api_name]}/#{params[:id]}"
    @api_response = HTTParty.get(@target,
      headers: { Authorization: "Bearer #{@session.access_token}" }
    )
  end

  def search_api_by_param
    @count = params[:count] || 10
    @page = params[:page] || 1
    @target = "https://dev-api.va.gov/services/argonaut/v0/#{params[:api_name]}?#{params[:search_param]}=#{@session.patient}&page=#{@page}&_count=#{@count}"
    @api_response = HTTParty.get(@target,
      headers: { Authorization: "Bearer #{@session.access_token}" }
    )

    if @api_response.code != 200
      render :api_request_failed and return
    end

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

    # replace all the "fullURL"s with links to api_by_param for those individual requests
    @response_string = JSON.pretty_generate(@api_response.to_h).gsub(/\"(https:\/\/dev-api.va.gov\/services\/argonaut\/v0\/#{params[:api_name]})\/(.+)\"/, "<a href=\"/health_api/api_response/#{params[:api_name]}/\\2\">\\1\/\\2</a>").html_safe
  end
end
