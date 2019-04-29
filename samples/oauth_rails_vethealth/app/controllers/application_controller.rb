class ApplicationController < ActionController::Base
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
end
