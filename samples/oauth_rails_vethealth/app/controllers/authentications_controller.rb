class AuthenticationsController < ApplicationController
  before_action :require_auth

  def show
    @authentication = Authentication.find(params[:id])
  end
end
