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
  end

  def condition
    @target = "https://dev-api.va.gov/services/argonaut/v0/Condition/#{@session.patient}"
    @api_response = HTTParty.get(@target,
      headers: { Authorization: "Bearer #{@session.access_token}" }
    )
    render :api_response
  end

  def allergy_intolerance
    @target = "https://dev-api.va.gov/services/argonaut/v0/AllergyIntolerance/#{@session.patient}"
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
