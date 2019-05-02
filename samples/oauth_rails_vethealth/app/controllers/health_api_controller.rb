class HealthApiController < ApplicationController
  before_action :require_auth

  def index
    @apis = [
      {text: 'Allergy Intolerance', uri_segment: 'AllergyIntolerance'},
      {text: 'Condition', uri_segment: 'Condition'},
      {text: 'Diagnostic Report', uri_segment: 'DiagnosticReport'},
      {text: 'Immunization', uri_segment: 'Immunization'},
      {text: 'Medication Order', uri_segment: 'MedicationOrder'},
      {text: 'Medication Statement', uri_segment: 'MedicationStatement'},
      {text: 'Observation', uri_segment: 'Observation'},
      {text: 'Patient', uri_segment: 'Patient'},
      {text: 'Procedure', uri_segment: 'Procedure'}
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
  end
end
