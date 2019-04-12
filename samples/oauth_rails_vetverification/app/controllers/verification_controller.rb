class VerificationController < ApplicationController
  before_action :require_auth

  def require_auth
    @session = Session.where(id: session[:id]).first
    if @session.nil?
      Rails.logger.warn "No session found"
      # TODO flash message, session not valid
      redirect_to login_path
    elsif @session.expires_at < Time.zone.now
      Rails.logger.warn "Session #{@session.id} expired"
      # TODO flash message, session not valid
      redirect_to login_path
    end
  end

  def show
    @name = @session.id_token_attributes['name']
    @veteran_verification = @session.veteran_verification
  end

end
