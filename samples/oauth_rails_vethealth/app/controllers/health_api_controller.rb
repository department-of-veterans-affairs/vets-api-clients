class HealthApiController < ApplicationController
  before_action :require_auth

  def require_auth
    @session = Session.where(id: session[:id]).first
    if @session.nil?
      Rails.logger.warn "No session found"
      flash.notice = "Login required"
      redirect_to(login_path) and return
    elsif !@session.validate_session(session)
      Rails.logger.warn "Session #{@session.id} expired"
      flash.notice = "Login expired, please login again"
      redirect_to(login_path) and return
    end
  end


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

  def metadata
    # TODO what's up with this?  it needs a special scope?
    @target = "https://dev-api.va.gov/services/argonaut/v0/Metadata"
    @api_response = HTTParty.get(@target,
      headers: { Authorization: "Bearer #{@session.access_token}" }
    )
    render :api_response
  end

  def api_by_param
    @target = "https://dev-api.va.gov/services/argonaut/v0/#{params[:api_name]}/#{@session.patient}"
    @api_response = HTTParty.get(@target,
      headers: { Authorization: "Bearer #{@session.access_token}" }
    )
    render :api_response
  end
end
