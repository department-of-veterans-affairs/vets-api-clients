class VerificationController < ApplicationController
  before_action :require_auth

  def require_auth
    @session = Session.where(id: session[:id]).first
    if @session.nil? || @session.expires_at < Time.zone.now
      # TODO flash message, session not valid
      redirect_to login_path
    end
  end

  def show
    @name = @session.id_token_attributes['name']
    @veteran_verification = @session.veteran_verification
    # TODO catch VeteranVerification::ResultsUnavailable errors and make something in the view to display them
  end

end
