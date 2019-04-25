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
    @condition = HTTParty.get(
        'https://dev-api.va.gov/services/argonaut/v0/Condition',
        query: { patient: @session.parsed_id_token['name'] },
        headers: { Authorization: "Bearer #{@session.access_token}" }
    )
  end
end
