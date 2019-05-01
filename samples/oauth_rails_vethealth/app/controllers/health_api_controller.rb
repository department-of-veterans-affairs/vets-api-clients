class HealthApiController < ApplicationController
  before_action :require_auth

  def index
    @apis = [
      {text: 'Allergy Intolerance', uri_segment: 'AllergyIntolerance'},
      {text: 'Condition', uri_segment: 'Condition'},
      {text: 'Diagnostic Report', uri_segment: 'DiagnosticReport'},
      {text: 'Immunization', uri_segment: 'Immunization'},
      {text: 'Medication', uri_segment: 'Medication'},
      {text: 'Medication Order', uri_segment: 'MedicationOrder'},
      {text: 'Medication Statement', uri_segment: 'MedicationStatement'},
      {text: 'Observation', uri_segment: 'Observation'},
      {text: 'Patient', uri_segment: 'Patient'},
      {text: 'Procedure', uri_segment: 'Procedure'}
    ]
  end

  def api_by_param
    @target = "https://dev-api.va.gov/services/argonaut/v0/#{params[:api_name]}/#{@session.patient}"
    @api_response = HTTParty.get(@target,
      headers: { Authorization: "Bearer #{@session.access_token}" }
    )
    render :api_response
  end

  def search_api_by_param
    @count = params[:count] || 10
    @page = params[:page] || 1
    @target = "https://dev-api.va.gov/services/argonaut/v0/#{params[:api_name]}?patient=#{@session.patient}&page=#{@page}&_count=#{@count}"
    @api_response = HTTParty.get(@target,
      headers: { Authorization: "Bearer #{@session.access_token}" }
    )

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

    # TODO extract all the full URLs and create links to api_by_param for those individual requests
  end
end
