class ApplicationController < ActionController::Base
  def require_auth
    @authentication = Authentication.where(id: session[:id]).first
    if @authentication.nil?
      Rails.logger.warn "No session found"
      flash.notice = "Login required"
      redirect_to(login_path) and return
    elsif !@authentication.validate_session(session)
      Rails.logger.warn "Authentication #{@authentication.id} expired"
      flash.notice = "Login expired, please login again"
      redirect_to(login_path) and return
    end
  end
end
