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
    @api_response = HealthApiResponse.new(
      api_name: params[:api_name],
      id: params[:id],
      access_token: @session.access_token
    )
  end

  def search_api_by_param
    @api_response = HealthApiResponse.new(
      api_name: params[:api_name],
      id: @session.patient,
      access_token: @session.access_token,
      action: :search,
      page: params[:page] || 1,
      count: params[:count] || 10
    )

    # TODO restore and support HealthApiResponse
    # if @api_response.code != 200
    #   render :api_request_failed and return
    # end
  end
end
