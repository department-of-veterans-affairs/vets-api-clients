class VerificationController < ApplicationController
  before_action :require_auth

  def require_auth
    @session = Session.where(id: session[:id]).first
    if @session.nil? || session.expired_at < Time.zone.now
      # TODO flash message, session not valid
      redirect_to login_path
    end
  end

  def show
    @veteran_verification = @session.veteran_verification
    @name = @session.id_token_attributes['name']
  end

end
