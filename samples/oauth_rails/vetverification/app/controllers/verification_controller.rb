class VerificationController < ApplicationController
  before_action :require_auth

  def require_auth
    @session = Session.where(id: session[:id]).first
    if @session.nil?
      Rails.logger.warn "No session found"
      flash.notice = "Login required"
      redirect_to(login_path) and return
    elsif @session.expired?
      Rails.logger.warn "Session #{@session.id} expired"
      flash.notice = "Login expired, please login again"
      redirect_to(login_path) and return
    end
  end

  def show
    @name = @session.id_token_attributes['name']
    @veteran_verification = @session.veteran_verification
  end
end
