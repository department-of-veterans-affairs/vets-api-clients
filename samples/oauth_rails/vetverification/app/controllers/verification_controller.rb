class VerificationController < ApplicationController
  before_action :require_auth

  def show
    @name = @session.id_token_attributes['name']
    @veteran_verification = @session.veteran_verification
  end
end
